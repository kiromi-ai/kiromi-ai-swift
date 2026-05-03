import XCTest
@testable import KiromiAI

final class Plan15Tests: XCTestCase {
    func testTypedLinkKindAndFindByKind() async throws {
        let tmp = FileManager.default.temporaryDirectory
            .appendingPathComponent("kiromi-ai-swift-plan15-\(UUID().uuidString)")
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
            partitionScheme: "user={user}/topic={topic}"
        )
        let parts = Partitions([("user","alex"),("topic","facts")])
        let a = try await store.append(parts, markdown: "first",
            options: AppendOptions(embedding: mockEmbedding("first")))
        let b = try await store.append(parts, markdown: "revised",
            options: AppendOptions(embedding: mockEmbedding("revised")))

        // Typed link: write Supersedes, read Supersedes back.
        try await store.addLink(from: b, to: a, kind: .supersedes)
        let supers = try await store.linksOf(a)
        XCTAssertEqual(supers.count, 1)
        XCTAssertEqual(supers[0].dst, b.id)

        // set_validity round-trips without error.
        try await store.setValidity(a, validFromMs: 100, validUntilMs: 200)

        // findByKind returns refs whose tag matches; default rows ride
        // along under the engine's MemoryKind::Episodic default.
        let episodics = try await store.find(kind: .episodic)
        XCTAssertEqual(episodics.count, 2)

        try await store.close()
    }
}
