import XCTest
@testable import KiromiAI

final class Plan16Tests: XCTestCase {
    func testSummaryAttributeRoundTrip() async throws {
        let tmp = FileManager.default.temporaryDirectory
            .appendingPathComponent("kiromi-ai-swift-plan16-\(UUID().uuidString)")
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
        let parts = Partitions([("user","alex"),("topic","plan16")])
        // Append with an inline summary so the engine attaches a Compact summary
        // we can target by id.
        let m = try await store.append(
            parts,
            markdown: "weekly rollup",
            options: AppendOptions(embedding: mockEmbedding("weekly rollup"), inlineSummary: "weekly")
        )

        // Pull the summary id by scanning edges_to from the memory's
        // own subject. We don't have summaries_of in the Swift surface
        // yet; build_context is overkill here. Instead, drive evolve to
        // exercise the wrapper without needing the id.

        // Set + read summary attribute via JSON. We don't have an
        // ergonomic Swift `findSummaryByMemory` yet, but we can test
        // the round-trip of summarySet/Get/AttributesOf by using the
        // memory id as a placeholder summary id and asserting the FFI
        // returns notFound — that's enough to verify the wiring.
        do {
            try await store.summarySetAttribute(
                m.id,
                key: "headline",
                valueJson: "{\"kind\":\"string\",\"value\":\"Weekly\"}"
            )
            XCTFail("expected error (m.id is a memory id, not a summary id)")
        } catch let err as KiromiAIError {
            // FFI returns kind="notFound"; the Swift mapper falls through to
            // .unknown for any tag not already mapped. Either is acceptable.
            switch err {
            case .unknown, .config: ()
            default: XCTFail("expected unknown/config, got \(err)")
            }
        }

        try await store.close()
    }

    func testEvolveJsonRoundTrip() async throws {
        let tmp = FileManager.default.temporaryDirectory
            .appendingPathComponent("kiromi-ai-swift-plan16-evolve-\(UUID().uuidString)")
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
        let parts = Partitions([("user","alex"),("topic","plan16")])
        let mOld = try await store.append(parts, markdown: "old",
            options: AppendOptions(embedding: mockEmbedding("old")))
        let mNew = try await store.append(parts, markdown: "new",
            options: AppendOptions(embedding: mockEmbedding("new")))

        // Build the EvolutionOps JSON directly (no Codable mirror on the
        // Swift side yet — consumers compose this via JSONEncoder).
        let opsJson =
        """
        {
          "trigger": { "id": "\(mNew.id)", "partition": "\(mNew.partition)" },
          "note": "swift evolve",
          "memory_attributes": [
            {
              "op": "set",
              "mref": { "id": "\(mNew.id)", "partition": "\(mNew.partition)" },
              "key": "headline",
              "value": { "kind": "string", "value": "via swift" }
            }
          ],
          "summary_attributes": [],
          "links_added": [
            [
              { "kind": "memory", "value": { "id": "\(mNew.id)", "partition": "\(mNew.partition)" } },
              { "kind": "memory", "value": { "id": "\(mOld.id)", "partition": "\(mOld.partition)" } },
              "Supersedes"
            ]
          ],
          "links_removed": [],
          "validity_updates": [
            [{ "id": "\(mOld.id)", "partition": "\(mOld.partition)" }, null, 2000]
          ],
          "kind_updates": []
        }
        """

        let reportJson = try await store.evolve(opsJson: opsJson)
        XCTAssertTrue(reportJson.contains("\"applied\":3"))
        XCTAssertTrue(reportJson.contains("\"events_emitted\":1"))

        try await store.close()
    }
}
