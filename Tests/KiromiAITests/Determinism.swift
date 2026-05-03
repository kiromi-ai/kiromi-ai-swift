import Foundation
import CryptoKit

/// Deterministic 384-dim L2-normalised float vector for a given input string.
/// Same input always produces the same vector. Used by the Swift test suite
/// in lieu of an actual embedding model.
func mockEmbedding(_ text: String, dims: Int = 384) -> [Float] {
    var out = [Float](repeating: 0, count: dims)
    var feed = Data(text.utf8)
    var idx = 0
    while idx < dims {
        // Re-hash to extend the byte stream.
        let h = SHA256.hash(data: feed)
        feed = Data(h)
        for byte in feed {
            if idx >= dims { break }
            // Map byte → [-1, 1].
            out[idx] = (Float(byte) / 127.5) - 1.0
            idx += 1
        }
    }
    // L2 normalise.
    let norm = sqrt(out.reduce(Float(0)) { $0 + $1 * $1 })
    if norm > 0 {
        for i in 0..<dims { out[i] /= norm }
    }
    return out
}
