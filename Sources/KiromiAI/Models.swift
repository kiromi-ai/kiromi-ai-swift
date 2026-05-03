import Foundation

public struct MemoryRef: Sendable, Hashable {
    public let id: String
    public let partition: String
    public init(id: String, partition: String) {
        self.id = id
        self.partition = partition
    }
}

public struct MemoryRecord: Sendable {
    public let ref: MemoryRef
    public let kind: String   // "md" or "txt"
    public let body: String
    public let bytes: UInt64
    public let createdAtMs: Int64
    public let updatedAtMs: Int64
    public let tombstoned: Bool
}

public struct Hit: Sendable {
    public let ref: MemoryRef
    public let score: Float
}

public struct AppendOptions: Sendable {
    public var embedding: [Float]
    public var inlineSummary: String?
    public init(embedding: [Float], inlineSummary: String? = nil) {
        self.embedding = embedding
        self.inlineSummary = inlineSummary
    }
}

public enum SearchMode: Sendable {
    case text
    case semantic
    case hybrid(alpha: Float)

    var rawTag: UInt32 {
        switch self {
        case .text: return 0
        case .semantic: return 1
        case .hybrid: return 2
        }
    }
    var alphaValue: Float {
        if case .hybrid(let a) = self { return a }
        return 0.6
    }
}

public struct SearchOptions: Sendable {
    public var mode: SearchMode
    public var topK: Int
    public var withinPartition: String?
    public init(mode: SearchMode = .text, topK: Int = 10, withinPartition: String? = nil) {
        self.mode = mode
        self.topK = topK
        self.withinPartition = withinPartition
    }
}

public struct LinkRecord: Sendable {
    public let src: String
    public let dst: String
    public let timestampMs: Int64
}

// MARK: Plan 12 — snapshots + restore.

public struct Snapshot: Sendable, Hashable {
    public let id: String
    public let seq: Int64
    public let createdAtMs: Int64
    public let tag: String?
    public let reason: String?
    public init(id: String, seq: Int64, createdAtMs: Int64, tag: String?, reason: String?) {
        self.id = id
        self.seq = seq
        self.createdAtMs = createdAtMs
        self.tag = tag
        self.reason = reason
    }
}

public struct RestoreReport: Sendable {
    public let memoriesReTombstoned: UInt64
    public let memoriesUnTombstoned: UInt64
    public let summariesReTombstoned: UInt64
    public let summariesUnTombstoned: UInt64
    public let linksAdded: UInt64
    public let linksRemoved: UInt64
    public let attributesSet: UInt64
    public let attributesCleared: UInt64
}

// MARK: Plan 15 — typed link kinds + bi-temporal validity + MemoryKind.

/// Mirror of `kiromi_ai_memory::LinkKind`. The persisted SQL tag matches
/// `rawValue` exactly so callers can round-trip through the bridge.
public enum LinkKind: String, Sendable {
    case explicit
    case supersedes
    case contradicts
    case derived
    case partOf = "part_of"
    case related
}

/// Mirror of `kiromi_ai_memory::MemoryKind`.
public enum MemoryKind: String, Sendable {
    case episodic
    case semantic
    case procedural
    case archival
    case working
}

/// Mirror of `kiromi_ai_memory::Scope`. The Swift FFI surface only
/// exposes the `.all` and `.partition(...)` variants for now since
/// `.tenant` collapses to `.all` at the Rust boundary.
public enum FindByKindScope: Sendable {
    case all
    case partition(String)

    var rawTag: String {
        switch self {
        case .all: return "all"
        case .partition(let path): return path
        }
    }
}

// MARK: Plan 19 — typed attributes, summaries, traversal, context, anchors, ops.

/// Mirror of `kiromi_ai_memory::AttributeValue`. Round-trips through
/// the FFI as the externally-tagged JSON shape
/// `{"kind": "<tag>", "value": <payload>}`.
public enum AttributeValue: Sendable, Equatable {
    case string(String)
    case int(Int64)
    /// Decimal carried as the canonical string form (e.g. `"12.50"`)
    /// — the engine roundtrips through `rust_decimal::Decimal` so
    /// integer-pair precision is preserved.
    case decimal(String)
    case bool(Bool)
    case timestamp(Int64)
    case array([AttributeValue])

    /// JSON shape Rust expects.
    public func toJSON() throws -> String {
        let data = try JSONSerialization.data(withJSONObject: toJSONObject())
        guard let s = String(data: data, encoding: .utf8) else {
            throw KiromiAIError.io(message: "AttributeValue: utf8 encode")
        }
        return s
    }

    private func toJSONObject() -> Any {
        switch self {
        case .string(let s): return ["kind": "string", "value": s]
        case .int(let n): return ["kind": "int", "value": NSNumber(value: n)]
        case .decimal(let s): return ["kind": "decimal", "value": s]
        case .bool(let b): return ["kind": "bool", "value": b]
        case .timestamp(let n): return ["kind": "timestamp", "value": NSNumber(value: n)]
        case .array(let xs): return ["kind": "array", "value": xs.map { $0.toJSONObject() }]
        }
    }

    /// Decode from the Rust-side JSON shape.
    public static func fromJSON(_ json: String) throws -> AttributeValue {
        guard let data = json.data(using: .utf8) else {
            throw KiromiAIError.io(message: "AttributeValue: invalid JSON utf8")
        }
        let any = try JSONSerialization.jsonObject(with: data)
        return try fromJSONObject(any)
    }

    internal static func fromJSONObject(_ any: Any) throws -> AttributeValue {
        guard let dict = any as? [String: Any], let kind = dict["kind"] as? String else {
            throw KiromiAIError.io(message: "AttributeValue: missing kind")
        }
        let value = dict["value"]
        switch kind {
        case "string":
            return .string((value as? String) ?? "")
        case "int":
            return .int(((value as? NSNumber)?.int64Value) ?? 0)
        case "decimal":
            // The Rust serde shape for Decimal is a string; some
            // encoders may also emit a number — accept either.
            if let s = value as? String { return .decimal(s) }
            if let n = value as? NSNumber { return .decimal(n.stringValue) }
            return .decimal("0")
        case "bool":
            return .bool((value as? Bool) ?? false)
        case "timestamp":
            return .timestamp(((value as? NSNumber)?.int64Value) ?? 0)
        case "array":
            let items = (value as? [Any]) ?? []
            return .array(try items.map { try fromJSONObject($0) })
        default:
            throw KiromiAIError.io(message: "AttributeValue: unknown kind \(kind)")
        }
    }
}

/// Mirror of `kiromi_ai_memory::SummaryStyle`.
public enum SummaryStyle: Sendable, Equatable {
    case compact
    case detailed
    /// Caller-defined preset. Persisted as `"custom:<name>"`.
    case custom(String)

    /// Encode to the JSON shape the engine expects.
    func toJSON() -> String {
        switch self {
        case .compact: return "\"Compact\""
        case .detailed: return "\"Detailed\""
        case .custom(let n):
            // serde JSON for `Custom(String)` is `{"Custom":"<n>"}`.
            let escaped = n.replacingOccurrences(of: "\"", with: "\\\"")
            return "{\"Custom\":\"\(escaped)\"}"
        }
    }
}

/// Mirror of `kiromi_ai_memory::SummarySubject` for FFI use. Encodes
/// through `JSONSerialization`.
public enum SummarySubject: Sendable, Equatable {
    case memory(MemoryRef)
    case partition(String)
    case tenant

    func toJSON() throws -> String {
        let obj: Any
        switch self {
        case .memory(let r):
            obj = ["kind": "memory", "value": ["id": r.id, "partition": r.partition]]
        case .partition(let p):
            obj = ["kind": "partition", "value": p]
        case .tenant:
            obj = ["kind": "tenant"]
        }
        let data = try JSONSerialization.data(withJSONObject: obj)
        guard let s = String(data: data, encoding: .utf8) else {
            throw KiromiAIError.io(message: "SummarySubject: utf8 encode")
        }
        return s
    }
}

/// Mirror of `kiromi_ai_memory::SummaryRef`. Returned across the FFI
/// as a JSON blob; consumers usually treat it as opaque.
public struct SummaryRef: Sendable, Equatable, Hashable {
    public let id: String
    public let subjectJSON: String
    public let styleJSON: String
    public let version: UInt32
    public init(id: String, subjectJSON: String, styleJSON: String, version: UInt32) {
        self.id = id
        self.subjectJSON = subjectJSON
        self.styleJSON = styleJSON
        self.version = version
    }
}

/// Mirror of `kiromi_ai_memory::SummaryRecord`. Storage body lives in
/// `prose`; structured blocks are surfaced via `blocksJSON` for
/// consumers that want the typed sidecar.
public struct SummaryRecord: Sendable {
    public let ref: SummaryRef
    public let prose: String
    public let blocksJSON: String
    public let summarizerId: String
    public let createdAtMs: Int64
}

/// Mirror of `kiromi_ai_memory::NodeRef` for FFI use.
public enum NodeRef: Sendable, Equatable {
    case memory(MemoryRef)
    case summary(id: String)
    case partition(String)

    /// Encode to the JSON shape the engine expects.
    func toJSON() throws -> String {
        let obj: Any
        switch self {
        case .memory(let r):
            obj = ["kind": "memory", "value": ["id": r.id, "partition": r.partition]]
        case .summary(let id):
            // The engine's NodeRef::Summary needs the full SummaryRef
            // shape; populate the placeholder fields the engine fills
            // back in when expanding edges.
            obj = ["kind": "summary", "value": [
                "id": id,
                "subject": ["kind": "tenant"] as [String: Any],
                "style": "Compact" as Any,
                "version": NSNumber(value: 0),
            ] as [String: Any]]
        case .partition(let p):
            obj = ["kind": "partition", "value": p]
        }
        let data = try JSONSerialization.data(withJSONObject: obj)
        guard let s = String(data: data, encoding: .utf8) else {
            throw KiromiAIError.io(message: "NodeRef: utf8 encode")
        }
        return s
    }
}

/// Mirror of `kiromi_ai_memory::Scope`.
public enum Scope: Sendable, Equatable {
    case all
    case tenant
    case partition(String)
    case memory(MemoryRef)

    func toJSON() throws -> String {
        let obj: Any
        switch self {
        case .all:
            obj = ["kind": "all"]
        case .tenant:
            obj = ["kind": "tenant"]
        case .partition(let p):
            obj = ["kind": "partition", "value": p]
        case .memory(let r):
            obj = ["kind": "memory", "value": ["id": r.id, "partition": r.partition]]
        }
        let data = try JSONSerialization.data(withJSONObject: obj)
        guard let s = String(data: data, encoding: .utf8) else {
            throw KiromiAIError.io(message: "Scope: utf8 encode")
        }
        return s
    }
}

/// Caller-tunable knobs for `KiromiAI.buildContext`.
public struct ContextOpts: Sendable, Equatable {
    public var budgetTokens: UInt32
    public var includeTenantMemo: Bool
    public var includeSummariesAt: [UInt32]
    public var includeMemoriesTopK: UInt32
    public var style: SummaryStyle
    public var ordering: ContextOrdering

    public init(
        budgetTokens: UInt32 = 4_000,
        includeTenantMemo: Bool = true,
        includeSummariesAt: [UInt32] = [0, 1],
        includeMemoriesTopK: UInt32 = 5,
        style: SummaryStyle = .compact,
        ordering: ContextOrdering = .topDown
    ) {
        self.budgetTokens = budgetTokens
        self.includeTenantMemo = includeTenantMemo
        self.includeSummariesAt = includeSummariesAt
        self.includeMemoriesTopK = includeMemoriesTopK
        self.style = style
        self.ordering = ordering
    }

    func toJSON() throws -> String {
        // Encode via JSONSerialization so the on-wire shape matches
        // the engine's #[serde(default)] field-by-field default impl.
        let orderingTag: String = {
            switch ordering {
            case .topDown: return "top_down"
            case .uCurve: return "u_curve"
            }
        }()
        let styleAny: Any
        switch style {
        case .compact: styleAny = "Compact"
        case .detailed: styleAny = "Detailed"
        case .custom(let n): styleAny = ["Custom": n]
        }
        let obj: [String: Any] = [
            "budget_tokens": NSNumber(value: budgetTokens),
            "include_tenant_memo": includeTenantMemo,
            "include_summaries_at": includeSummariesAt.map { NSNumber(value: $0) },
            "include_memories_top_k": NSNumber(value: includeMemoriesTopK),
            "style": styleAny,
            "ordering": orderingTag,
        ]
        let data = try JSONSerialization.data(withJSONObject: obj)
        guard let s = String(data: data, encoding: .utf8) else {
            throw KiromiAIError.io(message: "ContextOpts: utf8 encode")
        }
        return s
    }
}

public enum ContextOrdering: Sendable, Equatable {
    case topDown
    case uCurve
}

public enum ContextKind: String, Sendable, Equatable {
    case tenantMemo = "tenant_memo"
    case partitionSummary = "partition_summary"
    case memory = "memory"
    case linkedMemory = "linked_memory"
}

/// One block in an assembled context. The `anchorJSON` is a JSON
/// `NodeRef`; consumers usually just propagate it back into citation
/// strings without decoding.
public struct ContextBlock: Sendable {
    public let kind: ContextKind
    public let anchorJSON: String
    public let text: String
    public let tokensEstimated: UInt32
}

/// Snapshot-pinned diff result.
public struct ContextDiff: Sendable {
    public let added: [ContextBlock]
    public let removedAnchorsJSON: [String]
    public let keptAnchorsJSON: [String]
    public let tokensEstimatedAdded: UInt32
}

/// Knobs for `KiromiAI.vacuum`.
public struct VacuumOpts: Sendable, Equatable {
    public var maxPages: UInt32?
    public var includeFTS: Bool
    public init(maxPages: UInt32? = nil, includeFTS: Bool = false) {
        self.maxPages = maxPages
        self.includeFTS = includeFTS
    }
}

public struct VacuumReport: Sendable {
    public let pagesReclaimed: UInt64
    public let bytesFreed: UInt64
    public let durationMs: UInt64
}

public struct BackupReport: Sendable {
    public let bytesCopied: UInt64
    public let durationMs: UInt64
}

public struct CheckpointReport: Sendable {
    public let pagesWritten: UInt64
    public let framesTruncated: UInt32
}

/// One edge returned by `edgesFrom` / `edgesTo`. Carries the typed
/// `LinkKind` and the optional caller note alongside the JSON-encoded
/// node refs so consumers can hold the data without re-decoding.
public struct Edge: Sendable {
    public let srcJSON: String
    public let dstJSON: String
    public let kind: LinkKind
    public let createdAtMs: Int64
    public let note: String?
}

/// Result of `KiromiAI.resolveAnchor`. The `nodeJSON` is a JSON
/// `NodeRef`; `rangeJSON` carries the optional `DataPointRef` (line /
/// byte / time range) when the URI included one.
public struct AnchorResolution: Sendable {
    public let nodeJSON: String
    public let rangeJSON: String?
}
