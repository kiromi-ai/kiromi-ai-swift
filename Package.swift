// swift-tools-version:5.9
//
// kiromi-ai-swift — public Swift Package for the KiromiAI memory store.
//
// The Rust core lives in https://github.com/kiromi-ai/kiromi-mem (private).
// On every tagged release of kiromi-mem, the `release-swift-companion`
// workflow regenerates this package's Swift sources + bumps the binary
// target URL/checksum to match.
//
// Versioning: tag this repo at the SAME semver as kiromi-mem (e.g. 0.2.0).
//
// Local development:
//   The active binary target uses `.binaryTarget(path: ...)` so consumers
//   can resolve the package via `.package(path: ...)` without needing a
//   public R2 mirror to be reachable. To produce or refresh the local
//   `Frameworks/KiromiAIFFI.xcframework`, run:
//
//     bash scripts/fetch-xcframework.sh v0.2.0
//
//   …which downloads the matching artifact from the kiromi-mem private
//   GitHub release using the operator's `gh` CLI auth and unzips it.
//
// Public consumption (post-R2 cutover):
//   Once the kiromi-mem R2 mirror is configured for public reads, this
//   manifest will switch to `.binaryTarget(url:checksum:)` so consumers
//   can `.package(url: "https://github.com/kiromi-ai/kiromi-ai-swift",
//   from: "0.2.0")` with no path coupling and no auth.

import PackageDescription

let package = Package(
    name: "KiromiAI",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .library(name: "KiromiAI", targets: ["KiromiAI"]),
    ],
    targets: [
        // ───────────────────────────────────────────────────────────────
        //  Binary target — Rust FFI (kiromi-ai-swift crate, lipo'd
        //  static library + generated C header, packaged as xcframework).
        //
        //  ACTIVE: path-based (works for local + path-dep consumers).
        //  Swap to the url+checksum form below once R2 is public.
        // ───────────────────────────────────────────────────────────────
        .binaryTarget(
            name: "KiromiAIFFI",
            path: "Frameworks/KiromiAIFFI.xcframework"
        ),
        // INACTIVE — swap-in once a public R2 mirror is configured.
        //
        // .binaryTarget(
        //     name: "KiromiAIFFI",
        //     url: "https://<r2-public-base>/kiromi-ai-ffi/v0.2.0/KiromiAIFFI.xcframework.zip",
        //     checksum: "26cb7c10c2f4c6b4a23f87dbcb3e09846ba8275540de9a3a2f148af6315dead6"
        // ),

        // Generated swift-bridge bindings (copied verbatim from
        // `target/<arch>/release/swift-bridge-out/` by the kiromi-mem
        // release pipeline). Re-export the C symbols from KiromiAIFFI.
        .target(
            name: "SwiftBridgeGenerated",
            dependencies: ["KiromiAIFFI"],
            path: "Sources/SwiftBridgeGenerated"
        ),

        // The user-facing API — `KiromiAI`, `Partitions`, `Hit`,
        // `AppendOptions`, etc.
        .target(
            name: "KiromiAI",
            dependencies: ["SwiftBridgeGenerated"],
            path: "Sources/KiromiAI",
            linkerSettings: [
                // The Rust static lib transitively pulls in usearch's C++
                // runtime + system frameworks referenced by sqlx-sqlite,
                // ring, and friends. Without these the linker emits
                // "Undefined symbols" for std::__1::* on macOS.
                .linkedLibrary("c++"),
                .linkedFramework("CoreFoundation"),
                .linkedFramework("Security"),
                .linkedFramework("SystemConfiguration"),
            ]
        ),

        .testTarget(
            name: "KiromiAITests",
            dependencies: ["KiromiAI"],
            path: "Tests/KiromiAITests"
        ),
    ]
)
