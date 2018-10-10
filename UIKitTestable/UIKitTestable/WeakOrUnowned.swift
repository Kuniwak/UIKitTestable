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


    public var value: T? {
        switch self {
        case .weakReference(let weak):
            return weak.value
        case .unownedReference(let unowned):
            return unowned.value
        }
    }


    public var isReleased: Bool {
        switch self {
        case .weakReference(let weak):
            return weak.isReleased
        case .unownedReference(let unowned):
            return unowned.isReleased
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


    public init(_ value: T) {
        self.value = value
    }


    public init() {
        self.value = nil
    }


    public var isReleased: Bool {
        return self.value == nil
    }
}



public class Unowned<T: AnyObject> {
    public unowned var value: T
    private weak var weakValue: T?


    public init(_ value: T) {
        self.value = value
        self.weakValue = value
    }


    public var isReleased: Bool {
        return self.weakValue == nil
    }
}