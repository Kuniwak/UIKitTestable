public final class Unowned<T: AnyObject> {
    public private(set) unowned var value: T


    public init(_ value: T) {
        self.value = value
    }


    public func `do`(_ block: (T) throws -> Void) rethrows {
        try block(self.value)
    }


    public static func unowned(_ value: T) -> Unowned<T> {
        return Unowned(value)
    }


    public func asWeak() -> Weak<T> {
        return Weak(self.value)
    }


    public func asStrong() -> Strong<T> {
        return Strong(self.value)
    }
}
