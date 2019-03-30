public enum WeakOrUnowned<T: AnyObject> {
    case weakReference(Weak<T>)
    case unownedReference(Unowned<T>)


    public var weak: Weak<T>? {
        switch self {
        case .weakReference(let container):
            return container
        case .unownedReference:
            return nil
        }
    }


    public var unowned: Unowned<T>? {
        switch self {
        case .weakReference:
            return nil
        case .unownedReference(let container):
            return container
        }
    }


    public static func weak(_ value: T) -> WeakOrUnowned<T> {
        return .weakReference(Weak(value))
    }


    public static func unowned(_ value: T) -> WeakOrUnowned<T> {
        return .unownedReference(Unowned(value))
    }


    public static func empty() -> WeakOrUnowned<T> {
        return .weakReference(Weak<T>())
    }
}



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


    public func unowned() -> Unowned<T> {
        return Unowned(self.value!)
    }
}



public final class Unowned<T: AnyObject> {
    public unowned var value: T


    public init(_ value: T) {
        self.value = value
    }


    public func `do`(_ block: (T) throws -> Void) rethrows {
        try block(self.value)
    }


    public static func unowned(_ value: T) -> Unowned<T> {
        return Unowned(value)
    }


    public func weak() -> Weak<T> {
        return Weak(self.value)
    }
}
