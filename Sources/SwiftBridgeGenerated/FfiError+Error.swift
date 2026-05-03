// FfiError needs to conform to Swift's Error protocol so it can be thrown by
// the swift-bridge-generated `async throws` methods. swift-bridge does not
// automatically add this conformance for opaque Rust error types.

extension FfiError: @unchecked Sendable, Error {}
