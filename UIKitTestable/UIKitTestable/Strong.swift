public final class Strong<T: AnyObject> {
    public let value: T


    public init(_ value: T) {
        self.value = value
    }


    public func `do`(_ block: (T) throws -> Void) rethrows {
        try block(self.value)
    }


    public static func strong(_ value: T) -> Strong<T> {
        return Strong(value)
    }


    public func asWeak() -> Weak<T> {
        return Weak(self.value)
    }


    public func asUnowned() -> Unowned<T> {
        return Unowned(self.value)
    }
}
