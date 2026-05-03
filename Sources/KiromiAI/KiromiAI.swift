import Foundation
import SwiftBridgeGenerated

/// A handle to a kiromi-ai-memory store. Construct with `await KiromiAI.open(...)`.
///
/// Caller-provided embeddings are the canonical pathway: every `append` call
/// must include `AppendOptions.embedding` (a `[Float]` of the dimensionality
/// the store was opened with — typically 384 for the macOS transcriber's
/// default usage). Compute the vector with Apple Foundation Models,
/// `NaturalLanguage`, or `MLEmbeddingExtractor` on the Swift side.
///
/// Concurrency: `KiromiAI` is `Sendable`. The Rust engine serialises
/// concurrent writes per tenant via an internal mutex; reads are concurrent.
public final class KiromiAI: @unchecked Sendable {
    /// Internal — Plan 19 extensions in this module access this
    /// directly. External consumers should not touch it.
    internal var handle: KiromiAIHandle?

    private init(handle: KiromiAIHandle) {
        self.handle = handle
    }

    /// Open (or create) a store.
    ///
    /// - parameters:
    ///   - storagePath: directory holding the data files + indices.
    ///   - databasePath: SQLite metadata file (created if missing).
    ///   - tenant: tenant id (`[a-zA-Z0-9_-]{1,64}`).
    ///   - partitionScheme: e.g. `user={user}/year={year}/month={month}/topic={topic}`.
    public static func open(
        storagePath: String,
        databasePath: String,
        tenant: String,
        partitionScheme: String
    ) async throws -> KiromiAI {
        do {
            let h = try await KiromiAIHandle.open(storagePath, databasePath, tenant, partitionScheme)
            return KiromiAI(handle: h)
        } catch let err as FfiError {
            throw mapError(err)
        }
    }

    /// Graceful shutdown. Flushes index deltas to disk, closes pools.
    public func close() async throws {
        guard let h = handle else { return }
        handle = nil
        do {
            try await h.close()
        } catch let err as FfiError {
            throw mapError(err)
        }
    }

    /// Append a memory.
    ///
    /// `partitions` is rendered to its canonical `key=value/key=value` path
    /// string before crossing the FFI; the engine validates against the
    /// store's partition scheme.
    public func append(
        _ partitions: Partitions,
        markdown body: String,
        options: AppendOptions
    ) async throws -> MemoryRef {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        let path = renderPartitions(partitions)
        let embeddingVec = RustVec<Float>()
        for f in options.embedding { embeddingVec.push(value: f) }
        let opts = FfiAppendOptions(
            embedding: embeddingVec,
            inline_summary: (options.inlineSummary ?? "").intoRustString(),
            has_summary: options.inlineSummary != nil
        )
        do {
            let r = try await h.append(path, body, opts)
            return MemoryRef(id: r.id.toString(), partition: r.partition.toString())
        } catch let err as FfiError {
            throw mapError(err)
        }
    }

    public func get(_ ref: MemoryRef) async throws -> MemoryRecord {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do {
            let r = try await h.get(ref.id, ref.partition)
            return MemoryRecord(
                ref: MemoryRef(id: r.id.toString(), partition: r.partition.toString()),
                kind: r.kind.toString(),
                body: r.body.toString(),
                bytes: r.bytes,
                createdAtMs: r.created_at_ms,
                updatedAtMs: r.updated_at_ms,
                tombstoned: r.tombstoned
            )
        } catch let err as FfiError {
            throw mapError(err)
        }
    }

    public func list(_ partitions: Partitions, limit: Int = 100, includeTombstoned: Bool = false) async throws -> [MemoryRef] {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        let path = renderPartitions(partitions)
        do {
            let result = try await h.list(path, UInt32(limit), "", false, includeTombstoned)
            var out: [MemoryRef] = []
            let n = result.len()
            for i in 0..<n {
                let r = result.get(UInt(i))
                out.append(MemoryRef(id: r.id.toString(), partition: r.partition.toString()))
            }
            return out
        } catch let err as FfiError {
            throw mapError(err)
        }
    }

    public func search(_ query: String, options: SearchOptions = SearchOptions()) async throws -> [Hit] {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        let opts = FfiSearchOptions(
            mode: options.mode.rawTag,
            alpha: options.mode.alphaValue,
            top_k: UInt32(options.topK),
            within_partition: (options.withinPartition ?? "").intoRustString(),
            has_within: options.withinPartition != nil
        )
        do {
            let hits = try await h.search(query, opts)
            var out: [Hit] = []
            let n = hits.len()
            for i in 0..<n {
                let hit = hits.get(UInt(i))
                out.append(Hit(
                    ref: MemoryRef(id: hit.id.toString(), partition: hit.partition.toString()),
                    score: hit.score
                ))
            }
            return out
        } catch let err as FfiError {
            throw mapError(err)
        }
    }

    public func related(to ref: MemoryRef, topK: Int = 5) async throws -> [Hit] {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do {
            let hits = try await h.related(ref.id, ref.partition, UInt32(topK))
            var out: [Hit] = []
            let n = hits.len()
            for i in 0..<n {
                let hit = hits.get(UInt(i))
                out.append(Hit(
                    ref: MemoryRef(id: hit.id.toString(), partition: hit.partition.toString()),
                    score: hit.score
                ))
            }
            return out
        } catch let err as FfiError {
            throw mapError(err)
        }
    }

    public func delete(_ ref: MemoryRef) async throws {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do { try await h.delete(ref.id, ref.partition) }
        catch let err as FfiError {
            throw mapError(err)
        }
    }

    public func deletePartition(_ partitions: Partitions) async throws -> UInt64 {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        let path = renderPartitions(partitions)
        do {
            let outcome = try await h.delete_partition(path)
            return outcome.count
        } catch let err as FfiError {
            throw mapError(err)
        }
    }

    public func addLink(from src: MemoryRef, to dst: MemoryRef) async throws {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do { try await h.add_link(src.id, src.partition, dst.id, dst.partition) }
        catch let err as FfiError {
            throw mapError(err)
        }
    }

    public func removeLink(from src: MemoryRef, to dst: MemoryRef) async throws {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do { try await h.remove_link(src.id, src.partition, dst.id, dst.partition) }
        catch let err as FfiError {
            throw mapError(err)
        }
    }

    public func linksOf(_ ref: MemoryRef) async throws -> [LinkRecord] {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do {
            let links = try await h.links_of(ref.id, ref.partition)
            var out: [LinkRecord] = []
            let n = links.len()
            for i in 0..<n {
                let l = links.get(UInt(i))
                out.append(LinkRecord(src: l.src.toString(), dst: l.dst.toString(), timestampMs: l.ts_ms))
            }
            return out
        } catch let err as FfiError {
            throw mapError(err)
        }
    }

    // MARK: Plan 12 — snapshots + restore.

    public func snapshot(tag: String? = nil, reason: String? = nil) async throws -> Snapshot {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do {
            let s = try await h.snapshot_create(
                tag ?? "",
                tag != nil,
                reason ?? "",
                reason != nil
            )
            return Snapshot(
                id: s.id.toString(),
                seq: s.seq,
                createdAtMs: s.created_at_ms,
                tag: s.has_tag ? s.tag.toString() : nil,
                reason: s.has_reason ? s.reason.toString() : nil
            )
        } catch let err as FfiError {
            throw mapError(err)
        }
    }

    public func listSnapshots() async throws -> [Snapshot] {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do {
            let xs = try await h.snapshot_list()
            var out: [Snapshot] = []
            let n = xs.len()
            for i in 0..<n {
                let s = xs.get(UInt(i))
                out.append(Snapshot(
                    id: s.id.toString(),
                    seq: s.seq,
                    createdAtMs: s.created_at_ms,
                    tag: s.has_tag ? s.tag.toString() : nil,
                    reason: s.has_reason ? s.reason.toString() : nil
                ))
            }
            return out
        } catch let err as FfiError {
            throw mapError(err)
        }
    }

    public func deleteSnapshot(_ id: String) async throws {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do { try await h.snapshot_delete(id) }
        catch let err as FfiError { throw mapError(err) }
    }

    @discardableResult
    public func restore(_ id: String, alsoRestoreAttributes: Bool = true) async throws -> RestoreReport {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do {
            let r = try await h.snapshot_restore(id, alsoRestoreAttributes)
            return RestoreReport(
                memoriesReTombstoned: r.memories_re_tombstoned,
                memoriesUnTombstoned: r.memories_un_tombstoned,
                summariesReTombstoned: r.summaries_re_tombstoned,
                summariesUnTombstoned: r.summaries_un_tombstoned,
                linksAdded: r.links_added,
                linksRemoved: r.links_removed,
                attributesSet: r.attributes_set,
                attributesCleared: r.attributes_cleared
            )
        } catch let err as FfiError {
            throw mapError(err)
        }
    }

    // MARK: Plan 15 — typed link kinds, bi-temporal validity, MemoryKind.

    /// Plan 15: record a typed link (and its reverse).
    public func addLink(from src: MemoryRef, to dst: MemoryRef, kind: LinkKind) async throws {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do { try await h.add_link_typed(src.id, src.partition, dst.id, dst.partition, kind.rawValue) }
        catch let err as FfiError {
            throw mapError(err)
        }
    }

    /// Plan 15: update the bi-temporal validity range on a memory.
    public func setValidity(_ ref: MemoryRef, validFromMs: Int64?, validUntilMs: Int64?) async throws {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do {
            try await h.set_validity(
                ref.id,
                ref.partition,
                validFromMs ?? 0,
                validFromMs != nil,
                validUntilMs ?? 0,
                validUntilMs != nil
            )
        } catch let err as FfiError {
            throw mapError(err)
        }
    }

    // MARK: Plan 16 — summary attributes, generalized links, atomic batch evolve.

    /// Plan 16: upsert one typed attribute on a summary row.
    /// `valueJson` must be a JSON-encoded `AttributeValue` (externally
    /// tagged: `{"kind":"string","value":"…"}` etc).
    public func summarySetAttribute(_ summaryId: String, key: String, valueJson: String) async throws {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do { try await h.summary_set_attribute(summaryId, key, valueJson) }
        catch let err as FfiError { throw mapError(err) }
    }

    /// Plan 16: read one typed attribute on a summary row. Returns the
    /// JSON-encoded `AttributeValue`, or `nil` when absent.
    public func summaryGetAttribute(_ summaryId: String, key: String) async throws -> String? {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do {
            let s = try await h.summary_get_attribute(summaryId, key).toString()
            return s.isEmpty ? nil : s
        } catch let err as FfiError { throw mapError(err) }
    }

    /// Plan 16: every attribute on a summary row, JSON object map.
    public func summaryAttributesOf(_ summaryId: String) async throws -> String {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do { return try await h.summary_attributes_of(summaryId).toString() }
        catch let err as FfiError { throw mapError(err) }
    }

    /// Plan 16: insert a typed node↔node link. `srcJson` and `dstJson`
    /// are JSON-encoded `NodeRef` values (`{"kind":"memory","value":{"id":"…","partition":"…"}}`,
    /// `{"kind":"summary","value":{...}}`, `{"kind":"partition","value":"…"}`).
    /// `kind` is the persisted `LinkKind` tag.
    public func nodeLinkAdd(srcJson: String, dstJson: String, kind: LinkKind) async throws {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do { try await h.node_link_add(srcJson, dstJson, kind.rawValue) }
        catch let err as FfiError { throw mapError(err) }
    }

    /// Plan 16: remove a typed node↔node link.
    public func nodeLinkRemove(srcJson: String, dstJson: String, kind: LinkKind) async throws {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do { try await h.node_link_remove(srcJson, dstJson, kind.rawValue) }
        catch let err as FfiError { throw mapError(err) }
    }

    /// Plan 16: edges sourced at the supplied node. Returns the
    /// JSON array of `Edge` objects (so consumers can decode via Codable).
    public func edgesFrom(nodeJson: String) async throws -> String {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do { return try await h.node_edges_from(nodeJson).toString() }
        catch let err as FfiError { throw mapError(err) }
    }

    /// Plan 16: edges targeting the supplied node.
    public func edgesTo(nodeJson: String) async throws -> String {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do { return try await h.node_edges_to(nodeJson).toString() }
        catch let err as FfiError { throw mapError(err) }
    }

    /// Plan 16: apply a JSON-serialised `EvolutionOps` in one SQL
    /// transaction. Returns the JSON `{applied, audit_seq, events_emitted}`.
    public func evolve(opsJson: String) async throws -> String {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do { return try await h.evolve(opsJson).toString() }
        catch let err as FfiError { throw mapError(err) }
    }

    /// Plan 15: list refs whose `MemoryKind` matches.
    public func find(kind: MemoryKind, scope: FindByKindScope = .all) async throws -> [MemoryRef] {
        guard let h = handle else { throw KiromiAIError.config(message: "store is closed") }
        do {
            let xs = try await h.find_by_kind(kind.rawValue, scope.rawTag)
            var out: [MemoryRef] = []
            let n = xs.len()
            for i in 0..<n {
                let r = xs.get(UInt(i))
                out.append(MemoryRef(id: r.id.toString(), partition: r.partition.toString()))
            }
            return out
        } catch let err as FfiError {
            throw mapError(err)
        }
    }

    deinit {
        // We do NOT auto-close on deinit. close() is async and graceful;
        // callers must invoke it explicitly. Drop here only releases the
        // Rust handle, which forces the engine to abort without flushing.
        if handle != nil {
            FileHandle.standardError.write(Data(
                "kiromi-ai-memory: KiromiAI deinit'd without close() — index deltas may be lost\n".utf8
            ))
        }
    }

    /// Render `Partitions` to the canonical `key=value/key=value` path string.
    fileprivate func renderPartitions(_ partitions: Partitions) -> String {
        partitions.pairs.map { "\($0.0)=\($0.1)" }.joined(separator: "/")
    }
}

private func mapError(_ err: FfiError) -> KiromiAIError {
    KiromiAIError.from(
        kind: err.kind().toString(),
        message: err.message().toString(),
        detail: err.detail().toString()
    )
}
