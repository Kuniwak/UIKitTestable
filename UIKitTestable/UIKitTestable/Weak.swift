public class Weak<T: AnyObject> {
    public private(set) weak var value: T?


    public var isReleased: Bool {
        return self.value == nil
    }


    public init() {
        self.value = nil
    }


    public init(_ value: T) {
        self.value = value
    }


    public func `do`(_ block: (T?) throws -> Void) rethrows {
        try block(self.value)
    }


    public static func weak(_ value: T) -> Weak<T> {
        return Weak(value)
    }


    public func asUnowned() -> Unowned<T> {
        return Unowned(self.value!)
    }


    public func asStrong() -> Strong<T>? {
        guard let value = self.value else {
            return nil
        }
        return Strong(value)
    }
}
