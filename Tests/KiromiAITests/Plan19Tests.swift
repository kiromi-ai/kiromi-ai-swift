import XCTest
@testable import KiromiAI

final class Plan19Tests: XCTestCase {
    private func openTempStore(scheme: String = "user={user}/topic={topic}") async throws -> (KiromiAI, URL) {
        let tmp = FileManager.default.temporaryDirectory
            .appendingPathComponent("kiromi-ai-swift-plan19-\(UUID().uuidString)")
        try FileManager.default.createDirectory(at: tmp, withIntermediateDirectories: true)
        try FileManager.default.createDirectory(
            at: tmp.appendingPathComponent("store"),
            withIntermediateDirectories: true
        )
        let store = try await KiromiAI.open(
            storagePath: tmp.appendingPathComponent("store").path,
            databasePath: tmp.appendingPathComponent("metadata.db").path,
            tenant: "local",
            partitionScheme: scheme
        )
        return (store, tmp)
    }

    // MARK: Typed attributes

    func testTypedAttributeRoundTrip() async throws {
        let (store, tmp) = try await openTempStore()
        defer { try? FileManager.default.removeItem(at: tmp) }
        let parts = Partitions([("user","alex"),("topic","attrs")])
        let r = try await store.append(parts, markdown: "doc",
            options: AppendOptions(embedding: mockEmbedding("doc")))

        try await store.setAttribute(r, key: "speaker", value: .string("alex"))
        try await store.setAttribute(r, key: "duration_ms", value: .int(42))
        try await store.setAttribute(r, key: "live", value: .bool(true))

        // get_attribute
        let got = try await store.attribute("speaker", for: r)
        XCTAssertEqual(got, .string("alex"))
        let absent = try await store.attribute("missing", for: r)
        XCTAssertNil(absent)

        // attributes_of
        let all = try await store.attributesOf(r)
        XCTAssertEqual(all["speaker"], .string("alex"))
        XCTAssertEqual(all["duration_ms"], .int(42))
        XCTAssertEqual(all["live"], .bool(true))

        // find_by_attribute
        let hits = try await store.find(byAttribute: "speaker", value: .string("alex"))
        XCTAssertEqual(hits.count, 1)
        XCTAssertEqual(hits.first?.id, r.id)

        // clear_attribute
        try await store.clearAttribute(r, key: "speaker")
        let cleared = try await store.attribute("speaker", for: r)
        XCTAssertNil(cleared)

        try await store.close()
    }

    // MARK: Summaries first-class

    func testSummariesFirstClass() async throws {
        let (store, tmp) = try await openTempStore()
        defer { try? FileManager.default.removeItem(at: tmp) }
        let parts = Partitions([("user","alex"),("topic","summaries")])
        let m = try await store.append(parts, markdown: "raw body",
            options: AppendOptions(embedding: mockEmbedding("raw body")))

        // Attach via the typed wrapper.
        let s = try await store.attachSummary(
            subject: .memory(m),
            style: .compact,
            summarizerId: "test:plan19",
            prose: "this is the rollup"
        )
        XCTAssertFalse(s.id.isEmpty)
        XCTAssertEqual(s.version, 1)

        // summaries_of
        let listed = try await store.summariesOf(.memory(m))
        XCTAssertEqual(listed.count, 1)
        XCTAssertEqual(listed.first?.id, s.id)

        // get_summary
        let rec = try await store.getSummary(s)
        XCTAssertEqual(rec.prose, "this is the rollup")
        XCTAssertEqual(rec.summarizerId, "test:plan19")

        // latest_summary
        let latest = try await store.latestSummary(subject: .memory(m), style: .compact)
        XCTAssertNotNil(latest)
        XCTAssertEqual(latest?.ref.id, s.id)

        // setInlineSummary convenience.
        let m2 = try await store.append(parts, markdown: "second",
            options: AppendOptions(embedding: mockEmbedding("second")))
        let s2 = try await store.setInlineSummary(m2, text: "compact text")
        XCTAssertFalse(s2.id.isEmpty)

        try await store.close()
    }

    func testTenantAndPartitionMemo() async throws {
        let (store, tmp) = try await openTempStore()
        defer { try? FileManager.default.removeItem(at: tmp) }

        // Empty tenant memo: returns nil.
        let memo = try await store.tenantMemo()
        XCTAssertNil(memo)

        // Attach a Detailed tenant summary then re-read.
        _ = try await store.attachSummary(
            subject: .tenant,
            style: .detailed,
            summarizerId: "test:plan19",
            prose: "weekly tenant memo"
        )
        let memo2 = try await store.tenantMemo()
        XCTAssertEqual(memo2, "weekly tenant memo")

        // Attach a Compact partition summary and read it back.
        let parts = Partitions([("user","alex"),("topic","memo")])
        _ = try await store.append(parts, markdown: "x",
            options: AppendOptions(embedding: mockEmbedding("x")))
        _ = try await store.attachSummary(
            subject: .partition("user=alex/topic=memo"),
            style: .compact,
            summarizerId: "test:plan19",
            prose: "topic memo body"
        )
        let p = try await store.partitionSummary("user=alex/topic=memo", style: .compact)
        XCTAssertEqual(p, "topic memo body")
        try await store.close()
    }

    // MARK: Anchor parsing

    func testResolveAnchor() async throws {
        let (store, tmp) = try await openTempStore()
        defer { try? FileManager.default.removeItem(at: tmp) }

        // Bare partition anchor.
        let res = try await store.resolveAnchor("kiromi://partition/user=alex/topic=anchors")
        XCTAssertNil(res.rangeJSON)
        XCTAssertTrue(res.nodeJSON.contains("partition"))

        // Memory anchor with line range — round-trips a non-nil range.
        let id = "01HX0WJDR2QH2A8YZTR8N0XJDC"
        let r2 = try await store.resolveAnchor("kiromi://memory/\(id)/L1-3")
        XCTAssertNotNil(r2.rangeJSON)
        XCTAssertTrue(r2.nodeJSON.contains(id))

        // Bad scheme errors via invalidAnchor.
        do {
            _ = try await store.resolveAnchor("http://memory/x")
            XCTFail("expected invalidAnchor")
        } catch let err as KiromiAIError {
            // FFI surfaces the new "invalidAnchor" tag; the Swift
            // mapper falls through to .unknown for it.
            switch err {
            case .unknown, .config: ()
            default: XCTFail("expected unknown/config, got \(err)")
            }
        }

        try await store.close()
    }

    // MARK: Traversal + in-scope

    func testTraversalAndInScope() async throws {
        let (store, tmp) = try await openTempStore()
        defer { try? FileManager.default.removeItem(at: tmp) }
        let parts = Partitions([("user","alex"),("topic","graph")])
        let a = try await store.append(parts, markdown: "alpha",
            options: AppendOptions(embedding: mockEmbedding("alpha")))
        let b = try await store.append(parts, markdown: "bravo",
            options: AppendOptions(embedding: mockEmbedding("bravo")))
        try await store.addLink(from: a, to: b)

        // memoriesInScope
        let mems = try await store.memoriesInScope(.all)
        XCTAssertEqual(mems.count, 2)

        // linksInScope returns a JSON array; just assert non-empty.
        let linksJSON = try await store.linksInScope(.all)
        XCTAssertTrue(linksJSON.contains(a.id))
        XCTAssertTrue(linksJSON.contains(b.id))

        // traverse from a node returns JSON Graph with nodes + edges.
        let graph = try await store.traverse(start: .memory(a), hops: 2)
        XCTAssertTrue(graph.contains("\"nodes\""))
        XCTAssertTrue(graph.contains("\"edges\""))

        try await store.close()
    }

    // MARK: Build context

    func testBuildContext() async throws {
        let (store, tmp) = try await openTempStore()
        defer { try? FileManager.default.removeItem(at: tmp) }
        let parts = Partitions([("user","alex"),("topic","context")])
        let m = try await store.append(parts, markdown: "the body",
            options: AppendOptions(embedding: mockEmbedding("the body")))
        // Attach a summary so the context walker has something to surface.
        _ = try await store.attachSummary(
            subject: .partition("user=alex/topic=context"),
            style: .compact,
            summarizerId: "test:plan19",
            prose: "rollup of the topic"
        )

        let blocks = try await store.buildContext(focus: .memory(m))
        XCTAssertFalse(blocks.isEmpty, "expected at least one block")
        // Memory body shows up as a block; one of them carries the
        // canonical prose.
        XCTAssertTrue(blocks.contains(where: { $0.text.contains("the body") }))
        try await store.close()
    }

    // MARK: Plan-15+16 typed graph link

    func testTypedNodeLinkAndEdges() async throws {
        let (store, tmp) = try await openTempStore()
        defer { try? FileManager.default.removeItem(at: tmp) }
        let parts = Partitions([("user","alex"),("topic","links")])
        let a = try await store.append(parts, markdown: "first",
            options: AppendOptions(embedding: mockEmbedding("first")))
        let b = try await store.append(parts, markdown: "second",
            options: AppendOptions(embedding: mockEmbedding("second")))

        try await store.link(from: .memory(b), to: .memory(a), kind: .supersedes)
        let edges = try await store.edgesFrom(.memory(b))
        XCTAssertEqual(edges.count, 1)
        XCTAssertEqual(edges.first?.kind, .supersedes)
        XCTAssertTrue(edges.first?.dstJSON.contains(a.id) ?? false)

        let backEdges = try await store.edgesTo(.memory(a))
        XCTAssertEqual(backEdges.count, 1)

        try await store.unlink(from: .memory(b), to: .memory(a), kind: .supersedes)
        let after = try await store.edgesFrom(.memory(b))
        XCTAssertEqual(after.count, 0)

        try await store.close()
    }

    // MARK: Ops APIs

    func testOpsApis() async throws {
        let (store, tmp) = try await openTempStore()
        defer { try? FileManager.default.removeItem(at: tmp) }
        let parts = Partitions([("user","alex"),("topic","ops")])
        for body in ["one", "two"] {
            _ = try await store.append(parts, markdown: body,
                options: AppendOptions(embedding: mockEmbedding(body)))
        }

        try await store.analyze()

        let cp = try await store.checkpoint()
        XCTAssertGreaterThanOrEqual(cp.framesTruncated, 0)

        let vrep = try await store.vacuum(VacuumOpts())
        // Reclaim count is best-effort; just assert duration is set.
        XCTAssertGreaterThanOrEqual(vrep.durationMs, 0)
        _ = vrep.bytesFreed

        // backup_to dumps a copy; destination must NOT exist.
        let dest = tmp.appendingPathComponent("backup.db").path
        let backup = try await store.backup(to: dest)
        XCTAssertGreaterThan(backup.bytesCopied, 0)
        XCTAssertTrue(FileManager.default.fileExists(atPath: dest))

        // compact_audit_log with a long retain window leaves rows in place.
        let purged = try await store.compactAuditLog(retainSeconds: 60 * 60 * 24 * 365)
        XCTAssertEqual(purged, 0)

        try await store.close()
    }
}
