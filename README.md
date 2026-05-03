# kiromi-ai-swift

Public Swift Package for the [`kiromi-ai/kiromi-mem`](https://github.com/kiromi-ai/kiromi-mem) memory store.

This repo distributes the Swift API surface (`KiromiAI`, `Partitions`,
`Hit`, `AppendOptions`, etc.) and binds it to a precompiled
`KiromiAIFFI.xcframework` produced by the Rust core.

## Consumption

```swift
.package(url: "https://github.com/kiromi-ai/kiromi-ai-swift", from: "0.2.0"),
```

```swift
.product(name: "KiromiAI", package: "kiromi-ai-swift"),
```

## Versioning

Each tag here matches a tag on `kiromi-ai/kiromi-mem`. The XCFramework
attached to each release is bit-for-bit the artifact built by the
private kiromi-mem release CI; the `Sources/KiromiAI/*.swift` wrappers
are regenerated from the same release. Do not hand-edit the wrapper
sources here — submit changes upstream.

## Bumping to a new release

```bash
# Prerequisites: gh CLI authed as a kiromi-ai org member,
# and a local clone of kiromi-mem at ../kiromi-mem (or set $KIROMI_MEM_PATH).
bash scripts/bump-version.sh v0.3.0 --commit --tag --release
git push && git push --tags
```

Under the hood the script:

1. Downloads `KiromiAIFFI.xcframework.zip` from the kiromi-mem private GH
   release using your `gh` CLI auth, and verifies its checksum.
2. Re-syncs `Sources/KiromiAI/` and `Sources/SwiftBridgeGenerated/` from
   the kiromi-mem source tree.
3. Rewrites `Package.swift` with the new release's URL + checksum.
4. With `--commit --tag --release`: commits, tags, and creates the GH
   release on this repo with the xcframework attached as a binary asset.

The xcframework lives on **this repo's** GitHub Releases (public repo,
no auth needed for SPM). Source code privacy is preserved — the
binary itself isn't sensitive, only the Rust source is.

## Local development

`Package.swift` references the binary by URL once a release exists. For
unreleased builds you can populate `Frameworks/KiromiAIFFI.xcframework`
locally and temporarily switch the manifest to `.binaryTarget(path:)`:

```bash
bash scripts/fetch-xcframework.sh v0.2.0
# then edit Package.swift to use .binaryTarget(path: "Frameworks/KiromiAIFFI.xcframework")
```

## License

Dual-licensed under Apache-2.0 OR MIT, matching kiromi-mem.
