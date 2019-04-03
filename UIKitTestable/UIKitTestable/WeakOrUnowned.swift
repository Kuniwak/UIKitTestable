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
