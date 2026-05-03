import KiromiAIFFI
public struct FfiMemoryRef {
    public var id: RustString
    public var partition: RustString

    public init(id: RustString,partition: RustString) {
        self.id = id
        self.partition = partition
    }

    @inline(__always)
    func intoFfiRepr() -> __swift_bridge__$FfiMemoryRef {
        { let val = self; return __swift_bridge__$FfiMemoryRef(id: { let rustString = val.id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), partition: { let rustString = val.partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }()); }()
    }
}
extension __swift_bridge__$FfiMemoryRef {
    @inline(__always)
    func intoSwiftRepr() -> FfiMemoryRef {
        { let val = self; return FfiMemoryRef(id: RustString(ptr: val.id), partition: RustString(ptr: val.partition)); }()
    }
}
extension __swift_bridge__$Option$FfiMemoryRef {
    @inline(__always)
    func intoSwiftRepr() -> Optional<FfiMemoryRef> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }

    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<FfiMemoryRef>) -> __swift_bridge__$Option$FfiMemoryRef {
        if let v = val {
            return __swift_bridge__$Option$FfiMemoryRef(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$FfiMemoryRef(is_some: false, val: __swift_bridge__$FfiMemoryRef())
        }
    }
}
public struct FfiHit {
    public var id: RustString
    public var partition: RustString
    public var score: Float

    public init(id: RustString,partition: RustString,score: Float) {
        self.id = id
        self.partition = partition
        self.score = score
    }

    @inline(__always)
    func intoFfiRepr() -> __swift_bridge__$FfiHit {
        { let val = self; return __swift_bridge__$FfiHit(id: { let rustString = val.id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), partition: { let rustString = val.partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), score: val.score); }()
    }
}
extension __swift_bridge__$FfiHit {
    @inline(__always)
    func intoSwiftRepr() -> FfiHit {
        { let val = self; return FfiHit(id: RustString(ptr: val.id), partition: RustString(ptr: val.partition), score: val.score); }()
    }
}
extension __swift_bridge__$Option$FfiHit {
    @inline(__always)
    func intoSwiftRepr() -> Optional<FfiHit> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }

    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<FfiHit>) -> __swift_bridge__$Option$FfiHit {
        if let v = val {
            return __swift_bridge__$Option$FfiHit(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$FfiHit(is_some: false, val: __swift_bridge__$FfiHit())
        }
    }
}
public struct FfiMemoryRecord {
    public var id: RustString
    public var partition: RustString
    public var kind: RustString
    public var body: RustString
    public var bytes: UInt64
    public var created_at_ms: Int64
    public var updated_at_ms: Int64
    public var tombstoned: Bool

    public init(id: RustString,partition: RustString,kind: RustString,body: RustString,bytes: UInt64,created_at_ms: Int64,updated_at_ms: Int64,tombstoned: Bool) {
        self.id = id
        self.partition = partition
        self.kind = kind
        self.body = body
        self.bytes = bytes
        self.created_at_ms = created_at_ms
        self.updated_at_ms = updated_at_ms
        self.tombstoned = tombstoned
    }

    @inline(__always)
    func intoFfiRepr() -> __swift_bridge__$FfiMemoryRecord {
        { let val = self; return __swift_bridge__$FfiMemoryRecord(id: { let rustString = val.id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), partition: { let rustString = val.partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), kind: { let rustString = val.kind.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), body: { let rustString = val.body.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), bytes: val.bytes, created_at_ms: val.created_at_ms, updated_at_ms: val.updated_at_ms, tombstoned: val.tombstoned); }()
    }
}
extension __swift_bridge__$FfiMemoryRecord {
    @inline(__always)
    func intoSwiftRepr() -> FfiMemoryRecord {
        { let val = self; return FfiMemoryRecord(id: RustString(ptr: val.id), partition: RustString(ptr: val.partition), kind: RustString(ptr: val.kind), body: RustString(ptr: val.body), bytes: val.bytes, created_at_ms: val.created_at_ms, updated_at_ms: val.updated_at_ms, tombstoned: val.tombstoned); }()
    }
}
extension __swift_bridge__$Option$FfiMemoryRecord {
    @inline(__always)
    func intoSwiftRepr() -> Optional<FfiMemoryRecord> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }

    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<FfiMemoryRecord>) -> __swift_bridge__$Option$FfiMemoryRecord {
        if let v = val {
            return __swift_bridge__$Option$FfiMemoryRecord(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$FfiMemoryRecord(is_some: false, val: __swift_bridge__$FfiMemoryRecord())
        }
    }
}
public struct FfiLink {
    public var src: RustString
    public var dst: RustString
    public var ts_ms: Int64

    public init(src: RustString,dst: RustString,ts_ms: Int64) {
        self.src = src
        self.dst = dst
        self.ts_ms = ts_ms
    }

    @inline(__always)
    func intoFfiRepr() -> __swift_bridge__$FfiLink {
        { let val = self; return __swift_bridge__$FfiLink(src: { let rustString = val.src.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), dst: { let rustString = val.dst.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), ts_ms: val.ts_ms); }()
    }
}
extension __swift_bridge__$FfiLink {
    @inline(__always)
    func intoSwiftRepr() -> FfiLink {
        { let val = self; return FfiLink(src: RustString(ptr: val.src), dst: RustString(ptr: val.dst), ts_ms: val.ts_ms); }()
    }
}
extension __swift_bridge__$Option$FfiLink {
    @inline(__always)
    func intoSwiftRepr() -> Optional<FfiLink> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }

    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<FfiLink>) -> __swift_bridge__$Option$FfiLink {
        if let v = val {
            return __swift_bridge__$Option$FfiLink(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$FfiLink(is_some: false, val: __swift_bridge__$FfiLink())
        }
    }
}
public struct FfiDeletePartitionOutcome {
    public var count: UInt64

    public init(count: UInt64) {
        self.count = count
    }

    @inline(__always)
    func intoFfiRepr() -> __swift_bridge__$FfiDeletePartitionOutcome {
        { let val = self; return __swift_bridge__$FfiDeletePartitionOutcome(count: val.count); }()
    }
}
extension __swift_bridge__$FfiDeletePartitionOutcome {
    @inline(__always)
    func intoSwiftRepr() -> FfiDeletePartitionOutcome {
        { let val = self; return FfiDeletePartitionOutcome(count: val.count); }()
    }
}
extension __swift_bridge__$Option$FfiDeletePartitionOutcome {
    @inline(__always)
    func intoSwiftRepr() -> Optional<FfiDeletePartitionOutcome> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }

    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<FfiDeletePartitionOutcome>) -> __swift_bridge__$Option$FfiDeletePartitionOutcome {
        if let v = val {
            return __swift_bridge__$Option$FfiDeletePartitionOutcome(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$FfiDeletePartitionOutcome(is_some: false, val: __swift_bridge__$FfiDeletePartitionOutcome())
        }
    }
}
public struct FfiCountOutcome {
    public var count: UInt64

    public init(count: UInt64) {
        self.count = count
    }

    @inline(__always)
    func intoFfiRepr() -> __swift_bridge__$FfiCountOutcome {
        { let val = self; return __swift_bridge__$FfiCountOutcome(count: val.count); }()
    }
}
extension __swift_bridge__$FfiCountOutcome {
    @inline(__always)
    func intoSwiftRepr() -> FfiCountOutcome {
        { let val = self; return FfiCountOutcome(count: val.count); }()
    }
}
extension __swift_bridge__$Option$FfiCountOutcome {
    @inline(__always)
    func intoSwiftRepr() -> Optional<FfiCountOutcome> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }

    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<FfiCountOutcome>) -> __swift_bridge__$Option$FfiCountOutcome {
        if let v = val {
            return __swift_bridge__$Option$FfiCountOutcome(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$FfiCountOutcome(is_some: false, val: __swift_bridge__$FfiCountOutcome())
        }
    }
}
public struct FfiSnapshot {
    public var id: RustString
    public var seq: Int64
    public var created_at_ms: Int64
    public var tag: RustString
    public var has_tag: Bool
    public var reason: RustString
    public var has_reason: Bool

    public init(id: RustString,seq: Int64,created_at_ms: Int64,tag: RustString,has_tag: Bool,reason: RustString,has_reason: Bool) {
        self.id = id
        self.seq = seq
        self.created_at_ms = created_at_ms
        self.tag = tag
        self.has_tag = has_tag
        self.reason = reason
        self.has_reason = has_reason
    }

    @inline(__always)
    func intoFfiRepr() -> __swift_bridge__$FfiSnapshot {
        { let val = self; return __swift_bridge__$FfiSnapshot(id: { let rustString = val.id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), seq: val.seq, created_at_ms: val.created_at_ms, tag: { let rustString = val.tag.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), has_tag: val.has_tag, reason: { let rustString = val.reason.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), has_reason: val.has_reason); }()
    }
}
extension __swift_bridge__$FfiSnapshot {
    @inline(__always)
    func intoSwiftRepr() -> FfiSnapshot {
        { let val = self; return FfiSnapshot(id: RustString(ptr: val.id), seq: val.seq, created_at_ms: val.created_at_ms, tag: RustString(ptr: val.tag), has_tag: val.has_tag, reason: RustString(ptr: val.reason), has_reason: val.has_reason); }()
    }
}
extension __swift_bridge__$Option$FfiSnapshot {
    @inline(__always)
    func intoSwiftRepr() -> Optional<FfiSnapshot> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }

    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<FfiSnapshot>) -> __swift_bridge__$Option$FfiSnapshot {
        if let v = val {
            return __swift_bridge__$Option$FfiSnapshot(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$FfiSnapshot(is_some: false, val: __swift_bridge__$FfiSnapshot())
        }
    }
}
public struct FfiRestoreReport {
    public var memories_re_tombstoned: UInt64
    public var memories_un_tombstoned: UInt64
    public var summaries_re_tombstoned: UInt64
    public var summaries_un_tombstoned: UInt64
    public var links_added: UInt64
    public var links_removed: UInt64
    public var attributes_set: UInt64
    public var attributes_cleared: UInt64

    public init(memories_re_tombstoned: UInt64,memories_un_tombstoned: UInt64,summaries_re_tombstoned: UInt64,summaries_un_tombstoned: UInt64,links_added: UInt64,links_removed: UInt64,attributes_set: UInt64,attributes_cleared: UInt64) {
        self.memories_re_tombstoned = memories_re_tombstoned
        self.memories_un_tombstoned = memories_un_tombstoned
        self.summaries_re_tombstoned = summaries_re_tombstoned
        self.summaries_un_tombstoned = summaries_un_tombstoned
        self.links_added = links_added
        self.links_removed = links_removed
        self.attributes_set = attributes_set
        self.attributes_cleared = attributes_cleared
    }

    @inline(__always)
    func intoFfiRepr() -> __swift_bridge__$FfiRestoreReport {
        { let val = self; return __swift_bridge__$FfiRestoreReport(memories_re_tombstoned: val.memories_re_tombstoned, memories_un_tombstoned: val.memories_un_tombstoned, summaries_re_tombstoned: val.summaries_re_tombstoned, summaries_un_tombstoned: val.summaries_un_tombstoned, links_added: val.links_added, links_removed: val.links_removed, attributes_set: val.attributes_set, attributes_cleared: val.attributes_cleared); }()
    }
}
extension __swift_bridge__$FfiRestoreReport {
    @inline(__always)
    func intoSwiftRepr() -> FfiRestoreReport {
        { let val = self; return FfiRestoreReport(memories_re_tombstoned: val.memories_re_tombstoned, memories_un_tombstoned: val.memories_un_tombstoned, summaries_re_tombstoned: val.summaries_re_tombstoned, summaries_un_tombstoned: val.summaries_un_tombstoned, links_added: val.links_added, links_removed: val.links_removed, attributes_set: val.attributes_set, attributes_cleared: val.attributes_cleared); }()
    }
}
extension __swift_bridge__$Option$FfiRestoreReport {
    @inline(__always)
    func intoSwiftRepr() -> Optional<FfiRestoreReport> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }

    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<FfiRestoreReport>) -> __swift_bridge__$Option$FfiRestoreReport {
        if let v = val {
            return __swift_bridge__$Option$FfiRestoreReport(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$FfiRestoreReport(is_some: false, val: __swift_bridge__$FfiRestoreReport())
        }
    }
}
public struct FfiAppendOptions {
    public var embedding: RustVec<Float>
    public var inline_summary: RustString
    public var has_summary: Bool

    public init(embedding: RustVec<Float>,inline_summary: RustString,has_summary: Bool) {
        self.embedding = embedding
        self.inline_summary = inline_summary
        self.has_summary = has_summary
    }

    @inline(__always)
    func intoFfiRepr() -> __swift_bridge__$FfiAppendOptions {
        { let val = self; return __swift_bridge__$FfiAppendOptions(embedding: { let val = val.embedding; val.isOwned = false; return val.ptr }(), inline_summary: { let rustString = val.inline_summary.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), has_summary: val.has_summary); }()
    }
}
extension __swift_bridge__$FfiAppendOptions {
    @inline(__always)
    func intoSwiftRepr() -> FfiAppendOptions {
        { let val = self; return FfiAppendOptions(embedding: RustVec(ptr: val.embedding), inline_summary: RustString(ptr: val.inline_summary), has_summary: val.has_summary); }()
    }
}
extension __swift_bridge__$Option$FfiAppendOptions {
    @inline(__always)
    func intoSwiftRepr() -> Optional<FfiAppendOptions> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }

    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<FfiAppendOptions>) -> __swift_bridge__$Option$FfiAppendOptions {
        if let v = val {
            return __swift_bridge__$Option$FfiAppendOptions(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$FfiAppendOptions(is_some: false, val: __swift_bridge__$FfiAppendOptions())
        }
    }
}
public struct FfiSearchOptions {
    public var mode: UInt32
    public var alpha: Float
    public var top_k: UInt32
    public var within_partition: RustString
    public var has_within: Bool

    public init(mode: UInt32,alpha: Float,top_k: UInt32,within_partition: RustString,has_within: Bool) {
        self.mode = mode
        self.alpha = alpha
        self.top_k = top_k
        self.within_partition = within_partition
        self.has_within = has_within
    }

    @inline(__always)
    func intoFfiRepr() -> __swift_bridge__$FfiSearchOptions {
        { let val = self; return __swift_bridge__$FfiSearchOptions(mode: val.mode, alpha: val.alpha, top_k: val.top_k, within_partition: { let rustString = val.within_partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), has_within: val.has_within); }()
    }
}
extension __swift_bridge__$FfiSearchOptions {
    @inline(__always)
    func intoSwiftRepr() -> FfiSearchOptions {
        { let val = self; return FfiSearchOptions(mode: val.mode, alpha: val.alpha, top_k: val.top_k, within_partition: RustString(ptr: val.within_partition), has_within: val.has_within); }()
    }
}
extension __swift_bridge__$Option$FfiSearchOptions {
    @inline(__always)
    func intoSwiftRepr() -> Optional<FfiSearchOptions> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }

    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<FfiSearchOptions>) -> __swift_bridge__$Option$FfiSearchOptions {
        if let v = val {
            return __swift_bridge__$Option$FfiSearchOptions(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$FfiSearchOptions(is_some: false, val: __swift_bridge__$FfiSearchOptions())
        }
    }
}

public class KiromiAIHandle: KiromiAIHandleRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$KiromiAIHandle$_free(ptr)
        }
    }
}
extension KiromiAIHandle {
    class public func open<GenericIntoRustString: IntoRustString>(_ storage_path: GenericIntoRustString, _ database_path: GenericIntoRustString, _ tenant: GenericIntoRustString, _ scheme: GenericIntoRustString) async throws -> KiromiAIHandle {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$open>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(KiromiAIHandle(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<KiromiAIHandle, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$open(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$open(wrapperPtr, onComplete, { let rustString = storage_path.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = database_path.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = tenant.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = scheme.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$open {
        var cb: (Result<KiromiAIHandle, Error>) -> ()
    
        public init(cb: @escaping (Result<KiromiAIHandle, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func close() async throws -> () {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: UnsafeMutableRawPointer?) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$close>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal == nil {
                wrapper.cb(.success(()))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(), Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$close(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$close(wrapperPtr, onComplete, {isOwned = false; return ptr;}())
        })
    }
    class CbWrapper$KiromiAIHandle$close {
        var cb: (Result<(), Error>) -> ()
    
        public init(cb: @escaping (Result<(), Error>) -> ()) {
            self.cb = cb
        }
    }
}
public class KiromiAIHandleRefMut: KiromiAIHandleRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class KiromiAIHandleRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension KiromiAIHandleRef {
    public func append<GenericIntoRustString: IntoRustString>(_ partitions_path: GenericIntoRustString, _ body: GenericIntoRustString, _ options: FfiAppendOptions) async throws -> FfiMemoryRef {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __swift_bridge__$ResultFfiMemoryRefAndFfiError) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$append>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            switch rustFnRetVal.tag { case __swift_bridge__$ResultFfiMemoryRefAndFfiError$ResultOk: wrapper.cb(.success(rustFnRetVal.payload.ok.intoSwiftRepr())) case __swift_bridge__$ResultFfiMemoryRefAndFfiError$ResultErr: wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.payload.err))) default: fatalError() }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<FfiMemoryRef, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$append(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$append(wrapperPtr, onComplete, ptr, { let rustString = partitions_path.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = body.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), options.intoFfiRepr())
        })
    }
    class CbWrapper$KiromiAIHandle$append {
        var cb: (Result<FfiMemoryRef, Error>) -> ()
    
        public init(cb: @escaping (Result<FfiMemoryRef, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func get<GenericIntoRustString: IntoRustString>(_ ref_id: GenericIntoRustString, _ partition_path: GenericIntoRustString) async throws -> FfiMemoryRecord {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __swift_bridge__$ResultFfiMemoryRecordAndFfiError) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$get>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            switch rustFnRetVal.tag { case __swift_bridge__$ResultFfiMemoryRecordAndFfiError$ResultOk: wrapper.cb(.success(rustFnRetVal.payload.ok.intoSwiftRepr())) case __swift_bridge__$ResultFfiMemoryRecordAndFfiError$ResultErr: wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.payload.err))) default: fatalError() }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<FfiMemoryRecord, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$get(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$get(wrapperPtr, onComplete, ptr, { let rustString = ref_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = partition_path.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$get {
        var cb: (Result<FfiMemoryRecord, Error>) -> ()
    
        public init(cb: @escaping (Result<FfiMemoryRecord, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func list<GenericIntoRustString: IntoRustString>(_ partitions_path: GenericIntoRustString, _ limit: UInt32, _ cursor: GenericIntoRustString, _ has_cursor: Bool, _ include_tombstoned: Bool) async throws -> FfiMemoryRefList {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$list>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(FfiMemoryRefList(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<FfiMemoryRefList, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$list(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$list(wrapperPtr, onComplete, ptr, { let rustString = partitions_path.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), limit, { let rustString = cursor.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), has_cursor, include_tombstoned)
        })
    }
    class CbWrapper$KiromiAIHandle$list {
        var cb: (Result<FfiMemoryRefList, Error>) -> ()
    
        public init(cb: @escaping (Result<FfiMemoryRefList, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func delete<GenericIntoRustString: IntoRustString>(_ ref_id: GenericIntoRustString, _ partition_path: GenericIntoRustString) async throws -> () {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: UnsafeMutableRawPointer?) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$delete>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal == nil {
                wrapper.cb(.success(()))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(), Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$delete(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$delete(wrapperPtr, onComplete, ptr, { let rustString = ref_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = partition_path.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$delete {
        var cb: (Result<(), Error>) -> ()
    
        public init(cb: @escaping (Result<(), Error>) -> ()) {
            self.cb = cb
        }
    }

    public func delete_partition<GenericIntoRustString: IntoRustString>(_ partitions_path: GenericIntoRustString) async throws -> FfiDeletePartitionOutcome {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __swift_bridge__$ResultFfiDeletePartitionOutcomeAndFfiError) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$delete_partition>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            switch rustFnRetVal.tag { case __swift_bridge__$ResultFfiDeletePartitionOutcomeAndFfiError$ResultOk: wrapper.cb(.success(rustFnRetVal.payload.ok.intoSwiftRepr())) case __swift_bridge__$ResultFfiDeletePartitionOutcomeAndFfiError$ResultErr: wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.payload.err))) default: fatalError() }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<FfiDeletePartitionOutcome, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$delete_partition(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$delete_partition(wrapperPtr, onComplete, ptr, { let rustString = partitions_path.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$delete_partition {
        var cb: (Result<FfiDeletePartitionOutcome, Error>) -> ()
    
        public init(cb: @escaping (Result<FfiDeletePartitionOutcome, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func search<GenericIntoRustString: IntoRustString>(_ text: GenericIntoRustString, _ options: FfiSearchOptions) async throws -> FfiHitList {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$search>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(FfiHitList(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<FfiHitList, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$search(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$search(wrapperPtr, onComplete, ptr, { let rustString = text.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), options.intoFfiRepr())
        })
    }
    class CbWrapper$KiromiAIHandle$search {
        var cb: (Result<FfiHitList, Error>) -> ()
    
        public init(cb: @escaping (Result<FfiHitList, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func related<GenericIntoRustString: IntoRustString>(_ ref_id: GenericIntoRustString, _ partition_path: GenericIntoRustString, _ top_k: UInt32) async throws -> FfiHitList {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$related>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(FfiHitList(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<FfiHitList, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$related(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$related(wrapperPtr, onComplete, ptr, { let rustString = ref_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = partition_path.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), top_k)
        })
    }
    class CbWrapper$KiromiAIHandle$related {
        var cb: (Result<FfiHitList, Error>) -> ()
    
        public init(cb: @escaping (Result<FfiHitList, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func add_link<GenericIntoRustString: IntoRustString>(_ src_id: GenericIntoRustString, _ src_partition: GenericIntoRustString, _ dst_id: GenericIntoRustString, _ dst_partition: GenericIntoRustString) async throws -> () {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: UnsafeMutableRawPointer?) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$add_link>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal == nil {
                wrapper.cb(.success(()))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(), Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$add_link(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$add_link(wrapperPtr, onComplete, ptr, { let rustString = src_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = src_partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = dst_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = dst_partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$add_link {
        var cb: (Result<(), Error>) -> ()
    
        public init(cb: @escaping (Result<(), Error>) -> ()) {
            self.cb = cb
        }
    }

    public func remove_link<GenericIntoRustString: IntoRustString>(_ src_id: GenericIntoRustString, _ src_partition: GenericIntoRustString, _ dst_id: GenericIntoRustString, _ dst_partition: GenericIntoRustString) async throws -> () {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: UnsafeMutableRawPointer?) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$remove_link>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal == nil {
                wrapper.cb(.success(()))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(), Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$remove_link(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$remove_link(wrapperPtr, onComplete, ptr, { let rustString = src_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = src_partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = dst_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = dst_partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$remove_link {
        var cb: (Result<(), Error>) -> ()
    
        public init(cb: @escaping (Result<(), Error>) -> ()) {
            self.cb = cb
        }
    }

    public func links_of<GenericIntoRustString: IntoRustString>(_ ref_id: GenericIntoRustString, _ ref_partition: GenericIntoRustString) async throws -> FfiLinkList {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$links_of>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(FfiLinkList(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<FfiLinkList, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$links_of(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$links_of(wrapperPtr, onComplete, ptr, { let rustString = ref_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = ref_partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$links_of {
        var cb: (Result<FfiLinkList, Error>) -> ()
    
        public init(cb: @escaping (Result<FfiLinkList, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func snapshot_create<GenericIntoRustString: IntoRustString>(_ tag: GenericIntoRustString, _ has_tag: Bool, _ reason: GenericIntoRustString, _ has_reason: Bool) async throws -> FfiSnapshot {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __swift_bridge__$ResultFfiSnapshotAndFfiError) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$snapshot_create>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            switch rustFnRetVal.tag { case __swift_bridge__$ResultFfiSnapshotAndFfiError$ResultOk: wrapper.cb(.success(rustFnRetVal.payload.ok.intoSwiftRepr())) case __swift_bridge__$ResultFfiSnapshotAndFfiError$ResultErr: wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.payload.err))) default: fatalError() }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<FfiSnapshot, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$snapshot_create(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$snapshot_create(wrapperPtr, onComplete, ptr, { let rustString = tag.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), has_tag, { let rustString = reason.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), has_reason)
        })
    }
    class CbWrapper$KiromiAIHandle$snapshot_create {
        var cb: (Result<FfiSnapshot, Error>) -> ()
    
        public init(cb: @escaping (Result<FfiSnapshot, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func snapshot_list() async throws -> FfiSnapshotList {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$snapshot_list>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(FfiSnapshotList(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<FfiSnapshotList, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$snapshot_list(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$snapshot_list(wrapperPtr, onComplete, ptr)
        })
    }
    class CbWrapper$KiromiAIHandle$snapshot_list {
        var cb: (Result<FfiSnapshotList, Error>) -> ()
    
        public init(cb: @escaping (Result<FfiSnapshotList, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func snapshot_delete<GenericIntoRustString: IntoRustString>(_ id: GenericIntoRustString) async throws -> () {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: UnsafeMutableRawPointer?) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$snapshot_delete>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal == nil {
                wrapper.cb(.success(()))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(), Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$snapshot_delete(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$snapshot_delete(wrapperPtr, onComplete, ptr, { let rustString = id.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$snapshot_delete {
        var cb: (Result<(), Error>) -> ()
    
        public init(cb: @escaping (Result<(), Error>) -> ()) {
            self.cb = cb
        }
    }

    public func snapshot_restore<GenericIntoRustString: IntoRustString>(_ id: GenericIntoRustString, _ also_restore_attributes: Bool) async throws -> FfiRestoreReport {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __swift_bridge__$ResultFfiRestoreReportAndFfiError) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$snapshot_restore>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            switch rustFnRetVal.tag { case __swift_bridge__$ResultFfiRestoreReportAndFfiError$ResultOk: wrapper.cb(.success(rustFnRetVal.payload.ok.intoSwiftRepr())) case __swift_bridge__$ResultFfiRestoreReportAndFfiError$ResultErr: wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.payload.err))) default: fatalError() }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<FfiRestoreReport, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$snapshot_restore(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$snapshot_restore(wrapperPtr, onComplete, ptr, { let rustString = id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), also_restore_attributes)
        })
    }
    class CbWrapper$KiromiAIHandle$snapshot_restore {
        var cb: (Result<FfiRestoreReport, Error>) -> ()
    
        public init(cb: @escaping (Result<FfiRestoreReport, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func add_link_typed<GenericIntoRustString: IntoRustString>(_ src_id: GenericIntoRustString, _ src_partition: GenericIntoRustString, _ dst_id: GenericIntoRustString, _ dst_partition: GenericIntoRustString, _ kind: GenericIntoRustString) async throws -> () {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: UnsafeMutableRawPointer?) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$add_link_typed>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal == nil {
                wrapper.cb(.success(()))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(), Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$add_link_typed(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$add_link_typed(wrapperPtr, onComplete, ptr, { let rustString = src_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = src_partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = dst_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = dst_partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = kind.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$add_link_typed {
        var cb: (Result<(), Error>) -> ()
    
        public init(cb: @escaping (Result<(), Error>) -> ()) {
            self.cb = cb
        }
    }

    public func set_validity<GenericIntoRustString: IntoRustString>(_ ref_id: GenericIntoRustString, _ ref_partition: GenericIntoRustString, _ valid_from_ms: Int64, _ has_from: Bool, _ valid_until_ms: Int64, _ has_until: Bool) async throws -> () {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: UnsafeMutableRawPointer?) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$set_validity>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal == nil {
                wrapper.cb(.success(()))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(), Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$set_validity(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$set_validity(wrapperPtr, onComplete, ptr, { let rustString = ref_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = ref_partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), valid_from_ms, has_from, valid_until_ms, has_until)
        })
    }
    class CbWrapper$KiromiAIHandle$set_validity {
        var cb: (Result<(), Error>) -> ()
    
        public init(cb: @escaping (Result<(), Error>) -> ()) {
            self.cb = cb
        }
    }

    public func find_by_kind<GenericIntoRustString: IntoRustString>(_ kind: GenericIntoRustString, _ scope: GenericIntoRustString) async throws -> FfiMemoryRefList {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$find_by_kind>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(FfiMemoryRefList(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<FfiMemoryRefList, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$find_by_kind(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$find_by_kind(wrapperPtr, onComplete, ptr, { let rustString = kind.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = scope.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$find_by_kind {
        var cb: (Result<FfiMemoryRefList, Error>) -> ()
    
        public init(cb: @escaping (Result<FfiMemoryRefList, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func summary_set_attribute<GenericIntoRustString: IntoRustString>(_ summary_id: GenericIntoRustString, _ key: GenericIntoRustString, _ value_json: GenericIntoRustString) async throws -> () {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: UnsafeMutableRawPointer?) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$summary_set_attribute>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal == nil {
                wrapper.cb(.success(()))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(), Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$summary_set_attribute(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$summary_set_attribute(wrapperPtr, onComplete, ptr, { let rustString = summary_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = key.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = value_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$summary_set_attribute {
        var cb: (Result<(), Error>) -> ()
    
        public init(cb: @escaping (Result<(), Error>) -> ()) {
            self.cb = cb
        }
    }

    public func summary_get_attribute<GenericIntoRustString: IntoRustString>(_ summary_id: GenericIntoRustString, _ key: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$summary_get_attribute>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$summary_get_attribute(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$summary_get_attribute(wrapperPtr, onComplete, ptr, { let rustString = summary_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = key.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$summary_get_attribute {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func summary_attributes_of<GenericIntoRustString: IntoRustString>(_ summary_id: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$summary_attributes_of>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$summary_attributes_of(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$summary_attributes_of(wrapperPtr, onComplete, ptr, { let rustString = summary_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$summary_attributes_of {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func node_link_add<GenericIntoRustString: IntoRustString>(_ src_json: GenericIntoRustString, _ dst_json: GenericIntoRustString, _ kind: GenericIntoRustString) async throws -> () {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: UnsafeMutableRawPointer?) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$node_link_add>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal == nil {
                wrapper.cb(.success(()))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(), Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$node_link_add(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$node_link_add(wrapperPtr, onComplete, ptr, { let rustString = src_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = dst_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = kind.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$node_link_add {
        var cb: (Result<(), Error>) -> ()
    
        public init(cb: @escaping (Result<(), Error>) -> ()) {
            self.cb = cb
        }
    }

    public func node_link_remove<GenericIntoRustString: IntoRustString>(_ src_json: GenericIntoRustString, _ dst_json: GenericIntoRustString, _ kind: GenericIntoRustString) async throws -> () {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: UnsafeMutableRawPointer?) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$node_link_remove>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal == nil {
                wrapper.cb(.success(()))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(), Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$node_link_remove(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$node_link_remove(wrapperPtr, onComplete, ptr, { let rustString = src_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = dst_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = kind.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$node_link_remove {
        var cb: (Result<(), Error>) -> ()
    
        public init(cb: @escaping (Result<(), Error>) -> ()) {
            self.cb = cb
        }
    }

    public func node_edges_from<GenericIntoRustString: IntoRustString>(_ node_json: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$node_edges_from>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$node_edges_from(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$node_edges_from(wrapperPtr, onComplete, ptr, { let rustString = node_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$node_edges_from {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func node_edges_to<GenericIntoRustString: IntoRustString>(_ node_json: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$node_edges_to>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$node_edges_to(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$node_edges_to(wrapperPtr, onComplete, ptr, { let rustString = node_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$node_edges_to {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func evolve<GenericIntoRustString: IntoRustString>(_ ops_json: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$evolve>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$evolve(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$evolve(wrapperPtr, onComplete, ptr, { let rustString = ops_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$evolve {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func set_attribute<GenericIntoRustString: IntoRustString>(_ ref_id: GenericIntoRustString, _ ref_partition: GenericIntoRustString, _ key: GenericIntoRustString, _ value_json: GenericIntoRustString) async throws -> () {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: UnsafeMutableRawPointer?) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$set_attribute>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal == nil {
                wrapper.cb(.success(()))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(), Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$set_attribute(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$set_attribute(wrapperPtr, onComplete, ptr, { let rustString = ref_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = ref_partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = key.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = value_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$set_attribute {
        var cb: (Result<(), Error>) -> ()
    
        public init(cb: @escaping (Result<(), Error>) -> ()) {
            self.cb = cb
        }
    }

    public func clear_attribute<GenericIntoRustString: IntoRustString>(_ ref_id: GenericIntoRustString, _ ref_partition: GenericIntoRustString, _ key: GenericIntoRustString) async throws -> () {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: UnsafeMutableRawPointer?) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$clear_attribute>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal == nil {
                wrapper.cb(.success(()))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(), Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$clear_attribute(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$clear_attribute(wrapperPtr, onComplete, ptr, { let rustString = ref_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = ref_partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = key.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$clear_attribute {
        var cb: (Result<(), Error>) -> ()
    
        public init(cb: @escaping (Result<(), Error>) -> ()) {
            self.cb = cb
        }
    }

    public func get_attribute<GenericIntoRustString: IntoRustString>(_ ref_id: GenericIntoRustString, _ ref_partition: GenericIntoRustString, _ key: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$get_attribute>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$get_attribute(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$get_attribute(wrapperPtr, onComplete, ptr, { let rustString = ref_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = ref_partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = key.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$get_attribute {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func attributes_of<GenericIntoRustString: IntoRustString>(_ ref_id: GenericIntoRustString, _ ref_partition: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$attributes_of>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$attributes_of(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$attributes_of(wrapperPtr, onComplete, ptr, { let rustString = ref_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = ref_partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$attributes_of {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func find_by_attribute<GenericIntoRustString: IntoRustString>(_ key: GenericIntoRustString, _ value_json: GenericIntoRustString) async throws -> FfiMemoryRefList {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$find_by_attribute>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(FfiMemoryRefList(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<FfiMemoryRefList, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$find_by_attribute(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$find_by_attribute(wrapperPtr, onComplete, ptr, { let rustString = key.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = value_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$find_by_attribute {
        var cb: (Result<FfiMemoryRefList, Error>) -> ()
    
        public init(cb: @escaping (Result<FfiMemoryRefList, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func summary_clear_attribute<GenericIntoRustString: IntoRustString>(_ summary_id: GenericIntoRustString, _ key: GenericIntoRustString) async throws -> () {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: UnsafeMutableRawPointer?) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$summary_clear_attribute>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal == nil {
                wrapper.cb(.success(()))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(), Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$summary_clear_attribute(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$summary_clear_attribute(wrapperPtr, onComplete, ptr, { let rustString = summary_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = key.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$summary_clear_attribute {
        var cb: (Result<(), Error>) -> ()
    
        public init(cb: @escaping (Result<(), Error>) -> ()) {
            self.cb = cb
        }
    }

    public func find_summaries_by_attribute<GenericIntoRustString: IntoRustString>(_ key: GenericIntoRustString, _ value_json: GenericIntoRustString) async throws -> FfiSummaryRefList {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$find_summaries_by_attribute>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(FfiSummaryRefList(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<FfiSummaryRefList, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$find_summaries_by_attribute(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$find_summaries_by_attribute(wrapperPtr, onComplete, ptr, { let rustString = key.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = value_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$find_summaries_by_attribute {
        var cb: (Result<FfiSummaryRefList, Error>) -> ()
    
        public init(cb: @escaping (Result<FfiSummaryRefList, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func attach_summary<GenericIntoRustString: IntoRustString>(_ subject_json: GenericIntoRustString, _ style_json: GenericIntoRustString, _ summarizer_id: GenericIntoRustString, _ content_json: GenericIntoRustString, _ inputs_json: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$attach_summary>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$attach_summary(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$attach_summary(wrapperPtr, onComplete, ptr, { let rustString = subject_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = style_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = summarizer_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = content_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = inputs_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$attach_summary {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func get_summary<GenericIntoRustString: IntoRustString>(_ sref_json: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$get_summary>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$get_summary(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$get_summary(wrapperPtr, onComplete, ptr, { let rustString = sref_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$get_summary {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func latest_summary<GenericIntoRustString: IntoRustString>(_ subject_json: GenericIntoRustString, _ style_json: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$latest_summary>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$latest_summary(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$latest_summary(wrapperPtr, onComplete, ptr, { let rustString = subject_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = style_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$latest_summary {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func summaries_of<GenericIntoRustString: IntoRustString>(_ subject_json: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$summaries_of>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$summaries_of(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$summaries_of(wrapperPtr, onComplete, ptr, { let rustString = subject_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$summaries_of {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func tenant_memo() async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$tenant_memo>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$tenant_memo(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$tenant_memo(wrapperPtr, onComplete, ptr)
        })
    }
    class CbWrapper$KiromiAIHandle$tenant_memo {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func partition_summary<GenericIntoRustString: IntoRustString>(_ partition_path: GenericIntoRustString, _ style_json: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$partition_summary>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$partition_summary(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$partition_summary(wrapperPtr, onComplete, ptr, { let rustString = partition_path.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = style_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$partition_summary {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func set_inline_summary<GenericIntoRustString: IntoRustString>(_ ref_id: GenericIntoRustString, _ ref_partition: GenericIntoRustString, _ text: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$set_inline_summary>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$set_inline_summary(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$set_inline_summary(wrapperPtr, onComplete, ptr, { let rustString = ref_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = ref_partition.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = text.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$set_inline_summary {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func traverse<GenericIntoRustString: IntoRustString>(_ start_json: GenericIntoRustString, _ max_hops: UInt32, _ opts_json: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$traverse>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$traverse(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$traverse(wrapperPtr, onComplete, ptr, { let rustString = start_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), max_hops, { let rustString = opts_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$traverse {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func links_in_scope<GenericIntoRustString: IntoRustString>(_ scope_json: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$links_in_scope>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$links_in_scope(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$links_in_scope(wrapperPtr, onComplete, ptr, { let rustString = scope_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$links_in_scope {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func summaries_in_scope<GenericIntoRustString: IntoRustString>(_ scope_json: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$summaries_in_scope>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$summaries_in_scope(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$summaries_in_scope(wrapperPtr, onComplete, ptr, { let rustString = scope_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$summaries_in_scope {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func memories_in_scope<GenericIntoRustString: IntoRustString>(_ scope_json: GenericIntoRustString) async throws -> FfiMemoryRefList {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$memories_in_scope>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(FfiMemoryRefList(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<FfiMemoryRefList, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$memories_in_scope(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$memories_in_scope(wrapperPtr, onComplete, ptr, { let rustString = scope_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$memories_in_scope {
        var cb: (Result<FfiMemoryRefList, Error>) -> ()
    
        public init(cb: @escaping (Result<FfiMemoryRefList, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func build_context<GenericIntoRustString: IntoRustString>(_ focus_json: GenericIntoRustString, _ opts_json: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$build_context>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$build_context(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$build_context(wrapperPtr, onComplete, ptr, { let rustString = focus_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = opts_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$build_context {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func build_context_diff<GenericIntoRustString: IntoRustString>(_ focus_json: GenericIntoRustString, _ since_snapshot_id: GenericIntoRustString, _ opts_json: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$build_context_diff>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$build_context_diff(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$build_context_diff(wrapperPtr, onComplete, ptr, { let rustString = focus_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = since_snapshot_id.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = opts_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$build_context_diff {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func resolve_anchor<GenericIntoRustString: IntoRustString>(_ uri: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$resolve_anchor>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$resolve_anchor(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$resolve_anchor(wrapperPtr, onComplete, ptr, { let rustString = uri.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$resolve_anchor {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func ops_vacuum<GenericIntoRustString: IntoRustString>(_ opts_json: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$ops_vacuum>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$ops_vacuum(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$ops_vacuum(wrapperPtr, onComplete, ptr, { let rustString = opts_json.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$ops_vacuum {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func ops_analyze() async throws -> () {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: UnsafeMutableRawPointer?) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$ops_analyze>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal == nil {
                wrapper.cb(.success(()))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<(), Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$ops_analyze(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$ops_analyze(wrapperPtr, onComplete, ptr)
        })
    }
    class CbWrapper$KiromiAIHandle$ops_analyze {
        var cb: (Result<(), Error>) -> ()
    
        public init(cb: @escaping (Result<(), Error>) -> ()) {
            self.cb = cb
        }
    }

    public func ops_backup_to<GenericIntoRustString: IntoRustString>(_ dest_path: GenericIntoRustString) async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$ops_backup_to>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$ops_backup_to(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$ops_backup_to(wrapperPtr, onComplete, ptr, { let rustString = dest_path.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
        })
    }
    class CbWrapper$KiromiAIHandle$ops_backup_to {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func ops_compact_audit_log(_ retain_seconds: UInt64) async throws -> FfiCountOutcome {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __swift_bridge__$ResultFfiCountOutcomeAndFfiError) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$ops_compact_audit_log>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            switch rustFnRetVal.tag { case __swift_bridge__$ResultFfiCountOutcomeAndFfiError$ResultOk: wrapper.cb(.success(rustFnRetVal.payload.ok.intoSwiftRepr())) case __swift_bridge__$ResultFfiCountOutcomeAndFfiError$ResultErr: wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.payload.err))) default: fatalError() }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<FfiCountOutcome, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$ops_compact_audit_log(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$ops_compact_audit_log(wrapperPtr, onComplete, ptr, retain_seconds)
        })
    }
    class CbWrapper$KiromiAIHandle$ops_compact_audit_log {
        var cb: (Result<FfiCountOutcome, Error>) -> ()
    
        public init(cb: @escaping (Result<FfiCountOutcome, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func ops_checkpoint() async throws -> RustString {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$KiromiAIHandle$ops_checkpoint>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(FfiError(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$KiromiAIHandle$ops_checkpoint(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$KiromiAIHandle$ops_checkpoint(wrapperPtr, onComplete, ptr)
        })
    }
    class CbWrapper$KiromiAIHandle$ops_checkpoint {
        var cb: (Result<RustString, Error>) -> ()
    
        public init(cb: @escaping (Result<RustString, Error>) -> ()) {
            self.cb = cb
        }
    }
}
extension KiromiAIHandle: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_KiromiAIHandle$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_KiromiAIHandle$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: KiromiAIHandle) {
        __swift_bridge__$Vec_KiromiAIHandle$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_KiromiAIHandle$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (KiromiAIHandle(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<KiromiAIHandleRef> {
        let pointer = __swift_bridge__$Vec_KiromiAIHandle$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return KiromiAIHandleRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<KiromiAIHandleRefMut> {
        let pointer = __swift_bridge__$Vec_KiromiAIHandle$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return KiromiAIHandleRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<KiromiAIHandleRef> {
        UnsafePointer<KiromiAIHandleRef>(OpaquePointer(__swift_bridge__$Vec_KiromiAIHandle$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_KiromiAIHandle$len(vecPtr)
    }
}


public class FfiError: FfiErrorRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$FfiError$_free(ptr)
        }
    }
}
public class FfiErrorRefMut: FfiErrorRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class FfiErrorRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension FfiErrorRef {
    public func kind() -> RustStr {
        __swift_bridge__$FfiError$ffi_error_kind(ptr)
    }

    public func message() -> RustStr {
        __swift_bridge__$FfiError$ffi_error_message(ptr)
    }

    public func detail() -> RustStr {
        __swift_bridge__$FfiError$ffi_error_detail(ptr)
    }
}
extension FfiError: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_FfiError$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_FfiError$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: FfiError) {
        __swift_bridge__$Vec_FfiError$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_FfiError$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (FfiError(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<FfiErrorRef> {
        let pointer = __swift_bridge__$Vec_FfiError$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return FfiErrorRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<FfiErrorRefMut> {
        let pointer = __swift_bridge__$Vec_FfiError$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return FfiErrorRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<FfiErrorRef> {
        UnsafePointer<FfiErrorRef>(OpaquePointer(__swift_bridge__$Vec_FfiError$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_FfiError$len(vecPtr)
    }
}


public class FfiHitList: FfiHitListRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$FfiHitList$_free(ptr)
        }
    }
}
public class FfiHitListRefMut: FfiHitListRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class FfiHitListRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension FfiHitListRef {
    public func len() -> UInt {
        __swift_bridge__$FfiHitList$hit_list_len(ptr)
    }

    public func get(_ index: UInt) -> FfiHit {
        __swift_bridge__$FfiHitList$hit_list_get(ptr, index).intoSwiftRepr()
    }
}
extension FfiHitList: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_FfiHitList$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_FfiHitList$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: FfiHitList) {
        __swift_bridge__$Vec_FfiHitList$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_FfiHitList$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (FfiHitList(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<FfiHitListRef> {
        let pointer = __swift_bridge__$Vec_FfiHitList$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return FfiHitListRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<FfiHitListRefMut> {
        let pointer = __swift_bridge__$Vec_FfiHitList$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return FfiHitListRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<FfiHitListRef> {
        UnsafePointer<FfiHitListRef>(OpaquePointer(__swift_bridge__$Vec_FfiHitList$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_FfiHitList$len(vecPtr)
    }
}


public class FfiMemoryRefList: FfiMemoryRefListRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$FfiMemoryRefList$_free(ptr)
        }
    }
}
public class FfiMemoryRefListRefMut: FfiMemoryRefListRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class FfiMemoryRefListRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension FfiMemoryRefListRef {
    public func len() -> UInt {
        __swift_bridge__$FfiMemoryRefList$memory_ref_list_len(ptr)
    }

    public func get(_ index: UInt) -> FfiMemoryRef {
        __swift_bridge__$FfiMemoryRefList$memory_ref_list_get(ptr, index).intoSwiftRepr()
    }
}
extension FfiMemoryRefList: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_FfiMemoryRefList$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_FfiMemoryRefList$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: FfiMemoryRefList) {
        __swift_bridge__$Vec_FfiMemoryRefList$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_FfiMemoryRefList$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (FfiMemoryRefList(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<FfiMemoryRefListRef> {
        let pointer = __swift_bridge__$Vec_FfiMemoryRefList$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return FfiMemoryRefListRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<FfiMemoryRefListRefMut> {
        let pointer = __swift_bridge__$Vec_FfiMemoryRefList$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return FfiMemoryRefListRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<FfiMemoryRefListRef> {
        UnsafePointer<FfiMemoryRefListRef>(OpaquePointer(__swift_bridge__$Vec_FfiMemoryRefList$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_FfiMemoryRefList$len(vecPtr)
    }
}


public class FfiLinkList: FfiLinkListRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$FfiLinkList$_free(ptr)
        }
    }
}
public class FfiLinkListRefMut: FfiLinkListRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class FfiLinkListRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension FfiLinkListRef {
    public func len() -> UInt {
        __swift_bridge__$FfiLinkList$link_list_len(ptr)
    }

    public func get(_ index: UInt) -> FfiLink {
        __swift_bridge__$FfiLinkList$link_list_get(ptr, index).intoSwiftRepr()
    }
}
extension FfiLinkList: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_FfiLinkList$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_FfiLinkList$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: FfiLinkList) {
        __swift_bridge__$Vec_FfiLinkList$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_FfiLinkList$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (FfiLinkList(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<FfiLinkListRef> {
        let pointer = __swift_bridge__$Vec_FfiLinkList$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return FfiLinkListRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<FfiLinkListRefMut> {
        let pointer = __swift_bridge__$Vec_FfiLinkList$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return FfiLinkListRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<FfiLinkListRef> {
        UnsafePointer<FfiLinkListRef>(OpaquePointer(__swift_bridge__$Vec_FfiLinkList$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_FfiLinkList$len(vecPtr)
    }
}


public class FfiSnapshotList: FfiSnapshotListRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$FfiSnapshotList$_free(ptr)
        }
    }
}
public class FfiSnapshotListRefMut: FfiSnapshotListRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class FfiSnapshotListRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension FfiSnapshotListRef {
    public func len() -> UInt {
        __swift_bridge__$FfiSnapshotList$snapshot_list_len(ptr)
    }

    public func get(_ index: UInt) -> FfiSnapshot {
        __swift_bridge__$FfiSnapshotList$snapshot_list_get(ptr, index).intoSwiftRepr()
    }
}
extension FfiSnapshotList: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_FfiSnapshotList$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_FfiSnapshotList$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: FfiSnapshotList) {
        __swift_bridge__$Vec_FfiSnapshotList$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_FfiSnapshotList$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (FfiSnapshotList(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<FfiSnapshotListRef> {
        let pointer = __swift_bridge__$Vec_FfiSnapshotList$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return FfiSnapshotListRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<FfiSnapshotListRefMut> {
        let pointer = __swift_bridge__$Vec_FfiSnapshotList$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return FfiSnapshotListRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<FfiSnapshotListRef> {
        UnsafePointer<FfiSnapshotListRef>(OpaquePointer(__swift_bridge__$Vec_FfiSnapshotList$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_FfiSnapshotList$len(vecPtr)
    }
}


public class FfiSummaryRefList: FfiSummaryRefListRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$FfiSummaryRefList$_free(ptr)
        }
    }
}
public class FfiSummaryRefListRefMut: FfiSummaryRefListRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class FfiSummaryRefListRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension FfiSummaryRefListRef {
    public func len() -> UInt {
        __swift_bridge__$FfiSummaryRefList$summary_ref_list_len(ptr)
    }

    public func get(_ index: UInt) -> RustString {
        RustString(ptr: __swift_bridge__$FfiSummaryRefList$summary_ref_list_get(ptr, index))
    }
}
extension FfiSummaryRefList: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_FfiSummaryRefList$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_FfiSummaryRefList$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: FfiSummaryRefList) {
        __swift_bridge__$Vec_FfiSummaryRefList$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_FfiSummaryRefList$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (FfiSummaryRefList(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<FfiSummaryRefListRef> {
        let pointer = __swift_bridge__$Vec_FfiSummaryRefList$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return FfiSummaryRefListRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<FfiSummaryRefListRefMut> {
        let pointer = __swift_bridge__$Vec_FfiSummaryRefList$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return FfiSummaryRefListRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<FfiSummaryRefListRef> {
        UnsafePointer<FfiSummaryRefListRef>(OpaquePointer(__swift_bridge__$Vec_FfiSummaryRefList$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_FfiSummaryRefList$len(vecPtr)
    }
}



