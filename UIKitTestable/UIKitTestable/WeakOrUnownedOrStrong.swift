public enum WeakOrUnownedOrStrong<T: AnyObject> {
    case weakReference(Weak<T>)
    case unownedReference(Unowned<T>)
    case strongReference(Strong<T>)


    public var weak: Weak<T>? {
        switch self {
        case .weakReference(let container):
            return container
        case .unownedReference, .strongReference:
            return nil
        }
    }


    public var unowned: Unowned<T>? {
        switch self {
        case .weakReference, .strongReference:
            return nil
        case .unownedReference(let container):
            return container
        }
    }


    public var strong: Strong<T>? {
        switch self {
        case .weakReference, .unownedReference:
            return nil
        case .strongReference(let container):
            return container
        }
    }


    public static func weak(_ value: T) -> WeakOrUnownedOrStrong<T> {
        return .weakReference(Weak(value))
    }


    public static func unowned(_ value: T) -> WeakOrUnownedOrStrong<T> {
        return .unownedReference(Unowned(value))
    }


    public static func strong(_ value: T) -> WeakOrUnownedOrStrong<T> {
        return .strongReference(Strong(value))
    }


    public static func empty<T>() -> WeakOrUnownedOrStrong<T> {
        return .weakReference(Weak())
    }
}