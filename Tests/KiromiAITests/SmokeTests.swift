import XCTest
@testable import KiromiAI

final class SmokeTests: XCTestCase {
    func testOpenAppendGetListSearchClose() async throws {
        let tmp = FileManager.default.temporaryDirectory
            .appendingPathComponent("kiromi-ai-swift-smoke-\(UUID().uuidString)")
        try FileManager.default.createDirectory(at: tmp, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: tmp) }
        try FileManager.default.createDirectory(
            at: tmp.appendingPathComponent("store"),
            withIntermediateDirectories: true
        )

        let store = try await KiromiAI.open(
            storagePath: tmp.appendingPathComponent("store").path,
            databasePath: tmp.appendingPathComponent("metadata.db").path,
            tenant: "local",
            partitionScheme: "user={user}/year={year}/month={month}/topic={topic}"
        )

        let parts = Partitions([("user","alex"),("year","2026"),("month","05"),("topic","auth")])
        let body = "OAuth migration plan: rotate the keys nightly."
        let opts = AppendOptions(embedding: mockEmbedding(body))

        let ref = try await store.append(parts, markdown: body, options: opts)
        XCTAssertFalse(ref.id.isEmpty)
        XCTAssertTrue(ref.partition.contains("topic=auth"))

        let listed = try await store.list(parts)
        XCTAssertEqual(listed.count, 1)
        XCTAssertEqual(listed[0].id, ref.id)

        let got = try await store.get(ref)
        XCTAssertEqual(got.body, body)
        XCTAssertEqual(got.kind, "md")

        // Append a second doc so the per-leaf flush threshold (2) trips.
        let body2 = "Second OAuth ticket queued."
        _ = try await store.append(parts, markdown: body2,
            options: AppendOptions(embedding: mockEmbedding(body2)))
        // Allow the flusher tick.
        try await Task.sleep(nanoseconds: 700_000_000)

        let hits = try await store.search("OAuth", options: SearchOptions(mode: .text, topK: 5))
        XCTAssertFalse(hits.isEmpty, "text search returned nothing")

        try await store.close()
    }

    func testSemanticSearchFailsWithoutEmbedder() async throws {
        let tmp = FileManager.default.temporaryDirectory
            .appendingPathComponent("kiromi-ai-swift-semantic-\(UUID().uuidString)")
        try FileManager.default.createDirectory(at: tmp, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: tmp) }
        try FileManager.default.createDirectory(
            at: tmp.appendingPathComponent("store"),
            withIntermediateDirectories: true
        )

        let store = try await KiromiAI.open(
            storagePath: tmp.appendingPathComponent("store").path,
            databasePath: tmp.appendingPathComponent("metadata.db").path,
            tenant: "local",
            partitionScheme: "user={user}/year={year}/month={month}/topic={topic}"
        )
        let parts = Partitions([("user","alex"),("year","2026"),("month","05"),("topic","x")])
        _ = try await store.append(
            parts, markdown: "hello", options: AppendOptions(embedding: mockEmbedding("hello"))
        )

        do {
            _ = try await store.search("hello", options: SearchOptions(mode: .semantic, topK: 5))
            XCTFail("semantic search should fail without an embedder")
        } catch let err as KiromiAIError {
            if case .config = err { /* expected */ } else {
                XCTFail("expected .config error, got \(err)")
            }
        }
        try await store.close()
    }
}
