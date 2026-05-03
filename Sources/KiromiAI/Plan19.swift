import Foundation
import SwiftBridgeGenerated

// MARK: Plan 19 — typed attributes, summaries, traversal, context, anchors, ops.

extension KiromiAI {
    /// Internal helper — extensions in this file access the bridge
    /// handle through here so we don't proliferate the same `guard`
    /// across every method.
    func _ffiHandle() throws -> KiromiAIHandle {
        guard let h = self.handle else {
            throw KiromiAIError.config(message: "store is closed")
        }
        return h
    }
}

// MARK: Typed attributes

extension KiromiAI {
    /// Plan 11/19: attach (or overwrite) one typed attribute on a memory.
    public func setAttribute(_ ref: MemoryRef, key: String, value: AttributeValue) async throws {
        let h = try _ffiHandle()
        let json = try value.toJSON()
        do { try await h.set_attribute(ref.id, ref.partition, key, json) }
        catch let err as FfiError { throw mapFfi(err) }
    }

    /// Plan 11/19: remove one attribute. Idempotent.
    public func clearAttribute(_ ref: MemoryRef, key: String) async throws {
        let h = try _ffiHandle()
        do { try await h.clear_attribute(ref.id, ref.partition, key) }
        catch let err as FfiError { throw mapFfi(err) }
    }

    /// Plan 11/19: read one attribute, or `nil` when absent.
    public func attribute(_ key: String, for ref: MemoryRef) async throws -> AttributeValue? {
        let h = try _ffiHandle()
        let s: String
        do { s = try await h.get_attribute(ref.id, ref.partition, key).toString() }
        catch let err as FfiError { throw mapFfi(err) }
        if s.isEmpty { return nil }
        return try AttributeValue.fromJSON(s)
    }

    /// Plan 11/19: every attribute attached to `ref`, sorted by key.
    public func attributesOf(_ ref: MemoryRef) async throws -> [String: AttributeValue] {
        let h = try _ffiHandle()
        let s: String
        do { s = try await h.attributes_of(ref.id, ref.partition).toString() }
        catch let err as FfiError { throw mapFfi(err) }
        guard let data = s.data(using: .utf8),
              let any = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        else {
            return [:]
        }
        var out: [String: AttributeValue] = [:]
        for (k, v) in any {
            do { out[k] = try AttributeValue.fromJSONObject(v) } catch { /* skip malformed */ }
        }
        return out
    }

    /// Plan 11/19: every memory whose `(key, value)` matches exactly.
    public func find(byAttribute key: String, value: AttributeValue) async throws -> [MemoryRef] {
        let h = try _ffiHandle()
        let valueJson = try value.toJSON()
        let xs: FfiMemoryRefList
        do { xs = try await h.find_by_attribute(key, valueJson) }
        catch let err as FfiError { throw mapFfi(err) }
        var out: [MemoryRef] = []
        let n = xs.len()
        for i in 0..<n {
            let r = xs.get(UInt(i))
            out.append(MemoryRef(id: r.id.toString(), partition: r.partition.toString()))
        }
        return out
    }
}


// MARK: Summary attributes (Plan 16/19)

extension KiromiAI {
    /// Plan 16/19: clear one typed attribute on a summary row. Idempotent.
    public func summaryClearAttribute(_ summaryId: String, key: String) async throws {
        let h = try _ffiHandle()
        do { try await h.summary_clear_attribute(summaryId, key) }
        catch let err as FfiError { throw mapFfi(err) }
    }

    /// Plan 16/19: find every summary whose `(key, value)` matches.
    public func findSummaries(byAttribute key: String, value: AttributeValue) async throws -> [SummaryRef] {
        let h = try _ffiHandle()
        let valueJson = try value.toJSON()
        let xs: FfiSummaryRefList
        do { xs = try await h.find_summaries_by_attribute(key, valueJson) }
        catch let err as FfiError { throw mapFfi(err) }
        var out: [SummaryRef] = []
        for i in 0..<Int(xs.len()) {
            let s = xs.get(UInt(i)).toString()
            if let r = decodeSummaryRef(s) { out.append(r) }
        }
        return out
    }
}

// MARK: Summaries first-class (Plan 11/19)

extension KiromiAI {
    /// Plan 11/19: attach a structured summary to a subject. `content`
    /// may be a plain string (becomes the prose) or a pre-built
    /// `SummaryContent` JSON.
    @discardableResult
    public func attachSummary(
        subject: SummarySubject,
        style: SummaryStyle,
        summarizerId: String,
        prose: String,
        inputs: [SummarySubject] = []
    ) async throws -> SummaryRef {
        let h = try _ffiHandle()
        let subjectJson = try subject.toJSON()
        let styleJson = style.toJSON()
        // The engine accepts the SummaryContent JSON shape; emit the
        // simplest one — prose only, no blocks.
        let contentObj: [String: Any] = ["prose": prose, "blocks": [] as [Any]]
        let contentData = try JSONSerialization.data(withJSONObject: contentObj)
        let contentJson = String(data: contentData, encoding: .utf8) ?? "{}"
        var inputsJson = ""
        if !inputs.isEmpty {
            var arr: [Any] = []
            for s in inputs {
                guard let data = (try s.toJSON()).data(using: .utf8),
                      let obj = try? JSONSerialization.jsonObject(with: data) else {
                    throw KiromiAIError.io(message: "encode SummarySubject input")
                }
                arr.append(obj)
            }
            let data = try JSONSerialization.data(withJSONObject: arr)
            inputsJson = String(data: data, encoding: .utf8) ?? "[]"
        }
        let result: String
        do {
            result = try await h.attach_summary(
                subjectJson,
                styleJson,
                summarizerId,
                contentJson,
                inputsJson
            ).toString()
        } catch let err as FfiError { throw mapFfi(err) }
        guard let parsed = decodeSummaryRef(result) else {
            throw KiromiAIError.io(message: "attach_summary returned malformed JSON")
        }
        return parsed
    }

    /// Plan 19: convenience — equivalent to `attachSummary` on a
    /// memory subject with the `Compact` style and the canonical
    /// caller id `ffi:caller-summary`.
    @discardableResult
    public func setInlineSummary(_ ref: MemoryRef, text: String) async throws -> SummaryRef {
        let h = try _ffiHandle()
        let result: String
        do {
            result = try await h.set_inline_summary(ref.id, ref.partition, text).toString()
        } catch let err as FfiError { throw mapFfi(err) }
        guard let parsed = decodeSummaryRef(result) else {
            throw KiromiAIError.io(message: "set_inline_summary returned malformed JSON")
        }
        return parsed
    }

    /// Plan 11/19: read a summary by ref. Decodes the prose body and
    /// the JSON sidecar (if any).
    public func getSummary(_ ref: SummaryRef) async throws -> SummaryRecord {
        let h = try _ffiHandle()
        let refJson = try summaryRefJSON(ref)
        let result: String
        do { result = try await h.get_summary(refJson).toString() }
        catch let err as FfiError { throw mapFfi(err) }
        guard let rec = decodeSummaryRecord(result) else {
            throw KiromiAIError.io(message: "get_summary returned malformed JSON")
        }
        return rec
    }

    /// Plan 11/19: latest live summary for `(subject, style)`.
    public func latestSummary(
        subject: SummarySubject,
        style: SummaryStyle
    ) async throws -> SummaryRecord? {
        let h = try _ffiHandle()
        let subjectJson = try subject.toJSON()
        let styleJson = style.toJSON()
        let result: String
        do { result = try await h.latest_summary(subjectJson, styleJson).toString() }
        catch let err as FfiError { throw mapFfi(err) }
        if result.isEmpty { return nil }
        return decodeSummaryRecord(result)
    }

    /// Plan 11/19: every live summary on a subject.
    public func summariesOf(_ subject: SummarySubject) async throws -> [SummaryRef] {
        let h = try _ffiHandle()
        let subjectJson = try subject.toJSON()
        let result: String
        do { result = try await h.summaries_of(subjectJson).toString() }
        catch let err as FfiError { throw mapFfi(err) }
        return decodeSummaryRefArray(result)
    }

    /// Plan 19: tenant memo convenience — latest live `Detailed`
    /// summary for the tenant subject. Returns the rendered prose, or
    /// `nil` when none exists.
    public func tenantMemo() async throws -> String? {
        let h = try _ffiHandle()
        let s: String
        do { s = try await h.tenant_memo().toString() }
        catch let err as FfiError { throw mapFfi(err) }
        return s.isEmpty ? nil : s
    }

    /// Plan 19: partition memo convenience.
    public func partitionSummary(_ path: String, style: SummaryStyle) async throws -> String? {
        let h = try _ffiHandle()
        let s: String
        do { s = try await h.partition_summary(path, style.toJSON()).toString() }
        catch let err as FfiError { throw mapFfi(err) }
        return s.isEmpty ? nil : s
    }
}

// MARK: Traversal + in-scope (Plan 10/19)

extension KiromiAI {
    /// Plan 10/19: BFS-walk the memory ↔ summary ↔ partition graph from
    /// `start`. Returns the JSON-encoded `Graph` so consumers can
    /// decode against their own renderer types via `Codable`.
    public func traverse(
        start: NodeRef,
        hops: UInt32,
        optionsJSON: String? = nil
    ) async throws -> String {
        let h = try _ffiHandle()
        let startJson = try start.toJSON()
        let opts = optionsJSON ?? ""
        do { return try await h.traverse(startJson, hops, opts).toString() }
        catch let err as FfiError { throw mapFfi(err) }
    }

    /// Plan 10/19: every live link whose endpoints both fall under
    /// `scope`. Returns the JSON-encoded array.
    public func linksInScope(_ scope: Scope) async throws -> String {
        let h = try _ffiHandle()
        let scopeJson = try scope.toJSON()
        do { return try await h.links_in_scope(scopeJson).toString() }
        catch let err as FfiError { throw mapFfi(err) }
    }

    /// Plan 10/19: every live summary in scope. Returns the array of
    /// `SummaryRef` decoded from the engine's JSON.
    public func summariesInScope(_ scope: Scope) async throws -> [SummaryRef] {
        let h = try _ffiHandle()
        let scopeJson = try scope.toJSON()
        let s: String
        do { s = try await h.summaries_in_scope(scopeJson).toString() }
        catch let err as FfiError { throw mapFfi(err) }
        return decodeSummaryRefArray(s)
    }

    /// Plan 10/19: every live memory in scope.
    public func memoriesInScope(_ scope: Scope) async throws -> [MemoryRef] {
        let h = try _ffiHandle()
        let scopeJson = try scope.toJSON()
        let xs: FfiMemoryRefList
        do { xs = try await h.memories_in_scope(scopeJson) }
        catch let err as FfiError { throw mapFfi(err) }
        var out: [MemoryRef] = []
        for i in 0..<Int(xs.len()) {
            let r = xs.get(UInt(i))
            out.append(MemoryRef(id: r.id.toString(), partition: r.partition.toString()))
        }
        return out
    }
}

// MARK: Context assembly (Plan 12/19)

extension KiromiAI {
    /// Plan 12/19: assemble a token-budget-bounded list of context
    /// blocks rooted at `focus`.
    public func buildContext(
        focus: NodeRef,
        opts: ContextOpts = ContextOpts()
    ) async throws -> [ContextBlock] {
        let h = try _ffiHandle()
        let focusJson = try focus.toJSON()
        let optsJson = try opts.toJSON()
        let s: String
        do { s = try await h.build_context(focusJson, optsJson).toString() }
        catch let err as FfiError { throw mapFfi(err) }
        return decodeContextBlocks(s)
    }

    /// Plan 15/19: snapshot-anchored diff vs the live context.
    public func buildContextDiff(
        focus: NodeRef,
        sinceSnapshotId: String,
        opts: ContextOpts = ContextOpts()
    ) async throws -> ContextDiff {
        let h = try _ffiHandle()
        let focusJson = try focus.toJSON()
        let optsJson = try opts.toJSON()
        let s: String
        do { s = try await h.build_context_diff(focusJson, sinceSnapshotId, optsJson).toString() }
        catch let err as FfiError { throw mapFfi(err) }
        guard let data = s.data(using: .utf8),
              let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
        else { return ContextDiff(added: [], removedAnchorsJSON: [], keptAnchorsJSON: [], tokensEstimatedAdded: 0) }
        let added = decodeContextBlocks(dict["added"] ?? [])
        let removedRaw = (dict["removed"] as? [Any]) ?? []
        let keptRaw = (dict["kept"] as? [Any]) ?? []
        let removed = removedRaw.compactMap { jsonStringFor($0) }
        let kept = keptRaw.compactMap { jsonStringFor($0) }
        let tokens = ((dict["tokens_estimated_added"] as? NSNumber)?.uint32Value) ?? 0
        return ContextDiff(added: added, removedAnchorsJSON: removed, keptAnchorsJSON: kept, tokensEstimatedAdded: tokens)
    }
}

// MARK: Anchor parsing (Plan 11/19)

extension KiromiAI {
    /// Plan 11/19: parse a `kiromi://...` anchor URI into a typed
    /// `NodeRef` plus an optional sub-position.
    public func resolveAnchor(_ uri: String) async throws -> AnchorResolution {
        let h = try _ffiHandle()
        let s: String
        do { s = try await h.resolve_anchor(uri).toString() }
        catch let err as FfiError { throw mapFfi(err) }
        guard let data = s.data(using: .utf8),
              let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw KiromiAIError.io(message: "resolve_anchor returned malformed JSON")
        }
        let nodeJSON = jsonStringFor(dict["node"] as Any) ?? "{}"
        let rangeJSON: String?
        if let range = dict["range"] {
            if range is NSNull {
                rangeJSON = nil
            } else {
                rangeJSON = jsonStringFor(range)
            }
        } else {
            rangeJSON = nil
        }
        return AnchorResolution(nodeJSON: nodeJSON, rangeJSON: rangeJSON)
    }
}

// MARK: Plan-15 typed link kind on graph (Plan 16/19)

extension KiromiAI {
    /// Plan 16/19: typed node↔node link insert. Equivalent to the
    /// JSON-shaped `nodeLinkAdd` already exposed but takes `NodeRef`s
    /// directly.
    public func link(from src: NodeRef, to dst: NodeRef, kind: LinkKind) async throws {
        let h = try _ffiHandle()
        let s = try src.toJSON()
        let d = try dst.toJSON()
        do { try await h.node_link_add(s, d, kind.rawValue) }
        catch let err as FfiError { throw mapFfi(err) }
    }

    /// Plan 16/19: typed node↔node link remove.
    public func unlink(from src: NodeRef, to dst: NodeRef, kind: LinkKind) async throws {
        let h = try _ffiHandle()
        let s = try src.toJSON()
        let d = try dst.toJSON()
        do { try await h.node_link_remove(s, d, kind.rawValue) }
        catch let err as FfiError { throw mapFfi(err) }
    }

    /// Plan 16/19: edges sourced at `src`. Returns the typed array.
    public func edgesFrom(_ src: NodeRef) async throws -> [Edge] {
        let h = try _ffiHandle()
        let s = try src.toJSON()
        let json: String
        do { json = try await h.node_edges_from(s).toString() }
        catch let err as FfiError { throw mapFfi(err) }
        return decodeEdges(json)
    }

    /// Plan 16/19: edges targeting `dst`.
    public func edgesTo(_ dst: NodeRef) async throws -> [Edge] {
        let h = try _ffiHandle()
        let s = try dst.toJSON()
        let json: String
        do { json = try await h.node_edges_to(s).toString() }
        catch let err as FfiError { throw mapFfi(err) }
        return decodeEdges(json)
    }
}

// MARK: Ops APIs (Plan 18/19)

extension KiromiAI {
    /// Plan 18/19: compact the underlying SQLite database.
    @discardableResult
    public func vacuum(_ opts: VacuumOpts = VacuumOpts()) async throws -> VacuumReport {
        let h = try _ffiHandle()
        let dict: [String: Any] = [
            "max_pages": opts.maxPages.map { NSNumber(value: $0) } ?? NSNull(),
            "include_fts": opts.includeFTS,
        ]
        let data = try JSONSerialization.data(withJSONObject: dict)
        let optsJson = String(data: data, encoding: .utf8) ?? ""
        let s: String
        do { s = try await h.ops_vacuum(optsJson).toString() }
        catch let err as FfiError { throw mapFfi(err) }
        guard let body = s.data(using: .utf8),
              let obj = try? JSONSerialization.jsonObject(with: body) as? [String: Any]
        else { throw KiromiAIError.io(message: "vacuum returned malformed JSON") }
        return VacuumReport(
            pagesReclaimed: ((obj["pages_reclaimed"] as? NSNumber)?.uint64Value) ?? 0,
            bytesFreed: ((obj["bytes_freed"] as? NSNumber)?.uint64Value) ?? 0,
            durationMs: ((obj["duration_ms"] as? NSNumber)?.uint64Value) ?? 0
        )
    }

    /// Plan 18/19: run `ANALYZE` so the SQLite query planner has fresh stats.
    public func analyze() async throws {
        let h = try _ffiHandle()
        do { try await h.ops_analyze() }
        catch let err as FfiError { throw mapFfi(err) }
    }

    /// Plan 18/19: copy the live database to `path` via `VACUUM INTO`.
    @discardableResult
    public func backup(to path: String) async throws -> BackupReport {
        let h = try _ffiHandle()
        let s: String
        do { s = try await h.ops_backup_to(path).toString() }
        catch let err as FfiError { throw mapFfi(err) }
        guard let body = s.data(using: .utf8),
              let obj = try? JSONSerialization.jsonObject(with: body) as? [String: Any]
        else { throw KiromiAIError.io(message: "backup_to returned malformed JSON") }
        return BackupReport(
            bytesCopied: ((obj["bytes_copied"] as? NSNumber)?.uint64Value) ?? 0,
            durationMs: ((obj["duration_ms"] as? NSNumber)?.uint64Value) ?? 0
        )
    }

    /// Plan 18/19: drop audit-log entries older than `retainSeconds`.
    @discardableResult
    public func compactAuditLog(retainSeconds: UInt64) async throws -> UInt64 {
        let h = try _ffiHandle()
        do {
            let outcome = try await h.ops_compact_audit_log(retainSeconds)
            return outcome.count
        } catch let err as FfiError { throw mapFfi(err) }
    }

    /// Plan 18/19: run `PRAGMA wal_checkpoint(TRUNCATE)`.
    @discardableResult
    public func checkpoint() async throws -> CheckpointReport {
        let h = try _ffiHandle()
        let s: String
        do { s = try await h.ops_checkpoint().toString() }
        catch let err as FfiError { throw mapFfi(err) }
        guard let body = s.data(using: .utf8),
              let obj = try? JSONSerialization.jsonObject(with: body) as? [String: Any]
        else { throw KiromiAIError.io(message: "checkpoint returned malformed JSON") }
        return CheckpointReport(
            pagesWritten: ((obj["pages_written"] as? NSNumber)?.uint64Value) ?? 0,
            framesTruncated: ((obj["frames_truncated"] as? NSNumber)?.uint32Value) ?? 0
        )
    }
}

// MARK: Internal helpers

private func mapFfi(_ err: FfiError) -> KiromiAIError {
    KiromiAIError.from(
        kind: err.kind().toString(),
        message: err.message().toString(),
        detail: err.detail().toString()
    )
}

private func summaryRefJSON(_ ref: SummaryRef) throws -> String {
    // Reconstruct the JSON shape the engine expects:
    // { "id": "<ulid>", "subject": <subject>, "style": <style>, "version": <u32> }
    // The subject and style fields were captured at decode time. Style is
    // typically a JSON fragment (`"Compact"`) so we splice the strings
    // directly rather than round-tripping through JSONSerialization.
    let escapedId = ref.id.replacingOccurrences(of: "\"", with: "\\\"")
    return """
    {"id":"\(escapedId)","subject":\(ref.subjectJSON),"style":\(ref.styleJSON),"version":\(ref.version)}
    """
}

private func decodeSummaryRef(_ json: String) -> SummaryRef? {
    guard let data = json.data(using: .utf8),
          let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    else { return nil }
    let id = (dict["id"] as? String) ?? ""
    let subjectAny = dict["subject"] ?? [:]
    let styleAny = dict["style"] ?? "Compact"
    let version = ((dict["version"] as? NSNumber)?.uint32Value) ?? 0
    let subjectJSON: String = jsonStringFor(subjectAny) ?? "{}"
    let styleJSON: String = jsonStringFor(styleAny) ?? "\"Compact\""
    return SummaryRef(id: id, subjectJSON: subjectJSON, styleJSON: styleJSON, version: version)
}

private func decodeSummaryRefArray(_ json: String) -> [SummaryRef] {
    guard let data = json.data(using: .utf8),
          let arr = try? JSONSerialization.jsonObject(with: data) as? [Any]
    else { return [] }
    return arr.compactMap { item in
        guard let s = jsonStringFor(item) else { return nil }
        return decodeSummaryRef(s)
    }
}

private func decodeSummaryRecord(_ json: String) -> SummaryRecord? {
    guard let data = json.data(using: .utf8),
          let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    else { return nil }
    guard let refAny = dict["ref"], let refStr = jsonStringFor(refAny),
          let ref = decodeSummaryRef(refStr) else { return nil }
    let contentDict = (dict["content"] as? [String: Any]) ?? [:]
    let prose = (contentDict["prose"] as? String) ?? ""
    let blocksAny = contentDict["blocks"] ?? []
    let blocksJSON = jsonStringFor(blocksAny) ?? "[]"
    let summarizerId = (dict["summarizer_id"] as? String) ?? ""
    let createdAtMs = ((dict["created_at_ms"] as? NSNumber)?.int64Value) ?? 0
    return SummaryRecord(ref: ref, prose: prose, blocksJSON: blocksJSON, summarizerId: summarizerId, createdAtMs: createdAtMs)
}

private func decodeContextBlocks(_ raw: Any) -> [ContextBlock] {
    let json: Data
    if let s = raw as? String {
        guard let d = s.data(using: .utf8) else { return [] }
        json = d
    } else {
        guard let d = try? JSONSerialization.data(withJSONObject: raw) else { return [] }
        json = d
    }
    guard let arr = try? JSONSerialization.jsonObject(with: json) as? [Any] else { return [] }
    return arr.compactMap { item in
        guard let dict = item as? [String: Any] else { return nil }
        let kindStr = (dict["kind"] as? String) ?? ""
        let kind = ContextKind(rawValue: kindStr) ?? .memory
        let anchorJSON = jsonStringFor(dict["anchor"] as Any) ?? "{}"
        let text = (dict["text"] as? String) ?? ""
        let tokens = ((dict["tokens_estimated"] as? NSNumber)?.uint32Value) ?? 0
        return ContextBlock(kind: kind, anchorJSON: anchorJSON, text: text, tokensEstimated: tokens)
    }
}

private func decodeEdges(_ json: String) -> [Edge] {
    guard let data = json.data(using: .utf8),
          let arr = try? JSONSerialization.jsonObject(with: data) as? [Any]
    else { return [] }
    return arr.compactMap { item in
        guard let dict = item as? [String: Any] else { return nil }
        let srcJSON = jsonStringFor(dict["src"] as Any) ?? "{}"
        let dstJSON = jsonStringFor(dict["dst"] as Any) ?? "{}"
        let kindStr = (dict["kind"] as? String) ?? "Explicit"
        // Engine emits the variant name as-is (Serialize on enum without
        // rename_all), e.g. `"Explicit"` / `"Supersedes"`.
        let kind = LinkKind(rawValue: kindStr.lowercased()) ?? .explicit
        let createdAtMs = ((dict["created_at_ms"] as? NSNumber)?.int64Value) ?? 0
        let note = dict["note"] as? String
        return Edge(srcJSON: srcJSON, dstJSON: dstJSON, kind: kind, createdAtMs: createdAtMs, note: note)
    }
}

private func jsonStringFor(_ any: Any) -> String? {
    if let data = try? JSONSerialization.data(withJSONObject: any, options: [.fragmentsAllowed]),
       let s = String(data: data, encoding: .utf8) {
        return s
    }
    return nil
}
