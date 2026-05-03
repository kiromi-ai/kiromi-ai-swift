import Foundation

/// Ordered key-value bag describing where a memory lives.
///
/// Keys must match the partition scheme that the store was opened with.
public struct Partitions: Sendable, Equatable {
    public private(set) var pairs: [(String, String)]

    public init(_ pairs: [(String, String)] = []) {
        self.pairs = pairs
    }

    public init(_ dict: KeyValuePairs<String, String>) {
        self.pairs = dict.map { ($0.key, $0.value) }
    }

    @discardableResult
    public mutating func with(_ key: String, _ value: String) -> Self {
        pairs.append((key, value))
        return self
    }

    public static func == (lhs: Partitions, rhs: Partitions) -> Bool {
        lhs.pairs.elementsEqual(rhs.pairs, by: ==)
    }
}
