import XCTest
@testable import KiromiAI

final class RestartTests: XCTestCase {
    func testAppendCloseReopenSearch() async throws {
        let tmp = FileManager.default.temporaryDirectory
            .appendingPathComponent("kiromi-ai-swift-restart-\(UUID().uuidString)")
        try FileManager.default.createDirectory(at: tmp, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: tmp) }
        try FileManager.default.createDirectory(
            at: tmp.appendingPathComponent("store"),
            withIntermediateDirectories: true
        )

        let storagePath = tmp.appendingPathComponent("store").path
        let dbPath = tmp.appendingPathComponent("metadata.db").path
        let scheme = "user={user}/year={year}/month={month}/topic={topic}"

        // First open: append, close.
        do {
            let store = try await KiromiAI.open(
                storagePath: storagePath, databasePath: dbPath,
                tenant: "local", partitionScheme: scheme)
            let parts = Partitions([("user","alex"),("year","2026"),("month","05"),("topic","durable")])
            for body in ["alpha sequence", "beta sequence", "gamma sequence"] {
                _ = try await store.append(parts, markdown: body,
                    options: AppendOptions(embedding: mockEmbedding(body)))
            }
            // Wait for flush.
            try await Task.sleep(nanoseconds: 700_000_000)
            try await store.close()
        }

        // Reopen: text search still finds the rows.
        let store2 = try await KiromiAI.open(
            storagePath: storagePath, databasePath: dbPath,
            tenant: "local", partitionScheme: scheme)
        let hits = try await store2.search("alpha", options: SearchOptions(mode: .text, topK: 5))
        XCTAssertFalse(hits.isEmpty, "text search returned nothing after reopen")
        try await store2.close()
    }

    func testRelatedAfterReopen() async throws {
        let tmp = FileManager.default.temporaryDirectory
            .appendingPathComponent("kiromi-ai-swift-related-\(UUID().uuidString)")
        try FileManager.default.createDirectory(at: tmp, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: tmp) }
        try FileManager.default.createDirectory(
            at: tmp.appendingPathComponent("store"),
            withIntermediateDirectories: true
        )

        let storagePath = tmp.appendingPathComponent("store").path
        let dbPath = tmp.appendingPathComponent("metadata.db").path
        let scheme = "user={user}/year={year}/month={month}/topic={topic}"

        var firstRef: MemoryRef!
        do {
            let store = try await KiromiAI.open(
                storagePath: storagePath, databasePath: dbPath,
                tenant: "local", partitionScheme: scheme)
            let parts = Partitions([("user","alex"),("year","2026"),("month","05"),("topic","r")])
            firstRef = try await store.append(parts, markdown: "anchor doc",
                options: AppendOptions(embedding: mockEmbedding("anchor doc")))
            for body in ["related one", "related two", "related three"] {
                _ = try await store.append(parts, markdown: body,
                    options: AppendOptions(embedding: mockEmbedding(body)))
            }
            try await Task.sleep(nanoseconds: 700_000_000)
            try await store.close()
        }
        let store = try await KiromiAI.open(
            storagePath: storagePath, databasePath: dbPath,
            tenant: "local", partitionScheme: scheme)
        let neighbours = try await store.related(to: firstRef, topK: 3)
        XCTAssertEqual(neighbours.count, 3)
        XCTAssertTrue(neighbours.allSatisfy { $0.ref.id != firstRef.id })
        try await store.close()
    }
}
