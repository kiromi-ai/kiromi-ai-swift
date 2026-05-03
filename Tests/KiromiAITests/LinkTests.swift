import XCTest
@testable import KiromiAI

final class LinkTests: XCTestCase {
    func testAddRemoveListLinks() async throws {
        let tmp = FileManager.default.temporaryDirectory
            .appendingPathComponent("kiromi-ai-swift-link-\(UUID().uuidString)")
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
        let parts = Partitions([("user","alex"),("year","2026"),("month","05"),("topic","l")])
        let a = try await store.append(parts, markdown: "alpha",
            options: AppendOptions(embedding: mockEmbedding("alpha")))
        let b = try await store.append(parts, markdown: "bravo",
            options: AppendOptions(embedding: mockEmbedding("bravo")))

        try await store.addLink(from: a, to: b)
        let links = try await store.linksOf(a)
        XCTAssertEqual(links.count, 1)
        XCTAssertEqual(links[0].dst, b.id)

        try await store.removeLink(from: a, to: b)
        let after = try await store.linksOf(a)
        XCTAssertTrue(after.isEmpty)

        try await store.close()
    }
}
