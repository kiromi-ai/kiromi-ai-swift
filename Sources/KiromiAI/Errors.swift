import Foundation

/// All errors thrown by `KiromiAI` async APIs.
///
/// Case names mirror the Rust `kiromi_ai_memory::Error` variants; payloads come
/// from the FFI `FfiError.detail` JSON when present.
public enum KiromiAIError: Error, LocalizedError, Sendable, Equatable {
    case storage(message: String)
    case metadata(message: String)
    case embedder(message: String)
    case embedderMismatch(expected: String, expectedDims: Int, got: String, gotDims: Int, message: String)
    case partitionInvalid(message: String)
    case partitionSchemeInvalid(message: String)
    case partitionSchemeMismatch(expected: String, got: String, message: String)
    case tenantInvalid(message: String)
    case memoryNotFound(id: String, message: String)
    case tombstoned(id: String, message: String)
    case linkInvalid(message: String)
    case indexCorrupt(message: String)
    case recovery(message: String)
    case config(message: String)
    case capabilityMissing(plugin: String, required: String, got: Bool, message: String)
    case io(message: String)
    case snapshotNotFound(id: String, message: String)
    case embedderDimMismatch(old: Int, new: Int, message: String)
    case migrationConflict(reason: String, message: String)
    case unknown(kind: String, message: String)

    public var errorDescription: String? {
        switch self {
        case .storage(let m), .metadata(let m), .embedder(let m), .partitionInvalid(let m),
             .partitionSchemeInvalid(let m), .tenantInvalid(let m), .linkInvalid(let m),
             .indexCorrupt(let m), .recovery(let m), .config(let m), .io(let m):
            return m
        case .embedderMismatch(_, _, _, _, let m):
            return m
        case .partitionSchemeMismatch(_, _, let m):
            return m
        case .memoryNotFound(_, let m), .tombstoned(_, let m):
            return m
        case .capabilityMissing(_, _, _, let m):
            return m
        case .snapshotNotFound(_, let m):
            return m
        case .embedderDimMismatch(_, _, let m), .migrationConflict(_, let m):
            return m
        case .unknown(_, let m):
            return m
        }
    }

    /// Build from the FFI projection (kind tag + message + detail-JSON).
    public static func from(kind: String, message: String, detail: String) -> KiromiAIError {
        let detailJson: [String: Any] = {
            guard !detail.isEmpty,
                  let data = detail.data(using: .utf8),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            else { return [:] }
            return dict
        }()

        switch kind {
        case "storage": return .storage(message: message)
        case "metadata": return .metadata(message: message)
        case "embedder": return .embedder(message: message)
        case "embedderMismatch":
            let expected = detailJson["expected"] as? String ?? ""
            let expectedDims = detailJson["expectedDims"] as? Int ?? 0
            let got = detailJson["got"] as? String ?? ""
            let gotDims = detailJson["gotDims"] as? Int ?? 0
            return .embedderMismatch(expected: expected, expectedDims: expectedDims,
                                     got: got, gotDims: gotDims, message: message)
        case "partitionInvalid": return .partitionInvalid(message: message)
        case "partitionSchemeInvalid": return .partitionSchemeInvalid(message: message)
        case "partitionSchemeMismatch":
            let expected = detailJson["expected"] as? String ?? ""
            let got = detailJson["got"] as? String ?? ""
            return .partitionSchemeMismatch(expected: expected, got: got, message: message)
        case "tenantInvalid": return .tenantInvalid(message: message)
        case "memoryNotFound":
            let id = detailJson["id"] as? String ?? ""
            return .memoryNotFound(id: id, message: message)
        case "tombstoned":
            let id = detailJson["id"] as? String ?? ""
            return .tombstoned(id: id, message: message)
        case "linkInvalid": return .linkInvalid(message: message)
        case "indexCorrupt": return .indexCorrupt(message: message)
        case "recovery": return .recovery(message: message)
        case "config": return .config(message: message)
        case "capabilityMissing":
            let plugin = detailJson["plugin"] as? String ?? ""
            let required = detailJson["required"] as? String ?? ""
            let got = detailJson["got"] as? Bool ?? false
            return .capabilityMissing(plugin: plugin, required: required, got: got, message: message)
        case "io": return .io(message: message)
        case "snapshotNotFound":
            let id = detailJson["id"] as? String ?? ""
            return .snapshotNotFound(id: id, message: message)
        case "embedderDimMismatch":
            let old = detailJson["old"] as? Int ?? 0
            let new = detailJson["new"] as? Int ?? 0
            return .embedderDimMismatch(old: old, new: new, message: message)
        case "migrationConflict":
            let reason = detailJson["reason"] as? String ?? ""
            return .migrationConflict(reason: reason, message: message)
        default: return .unknown(kind: kind, message: message)
        }
    }
}
