/// A class for weak or unowned or strong references.
/// This class can be used to users can determine how the value should be held.
public enum WeakOrUnownedOrStrong<T: AnyObject> {
    /// A case for weak references.
    case weakReference(Weak<T>)
    /// A case for unowned references.
    case unownedReference(Unowned<T>)
    /// A case for strong references.
    case strongReference(Strong<T>)


    /// Returns a weak reference if this is a weak reference. Otherwise nil.
    /// - Returns: A weak reference if this is a weak reference. Otherwise nil.
    public var weak: Weak<T>? {
        switch self {
        case .weakReference(let container):
            return container
        case .unownedReference, .strongReference:
            return nil
        }
    }


    /// Returns an unowned reference if this is an unowned reference. Otherwise nil.
    /// - Returns: An unowned reference if this is an unowned reference. Otherwise nil.
    public var unowned: Unowned<T>? {
        switch self {
        case .weakReference, .strongReference:
            return nil
        case .unownedReference(let container):
            return container
        }
    }


    /// Returns a strong reference if this is a strong reference. Otherwise nil.
    /// - Returns: A strong reference if this is a strong reference. Otherwise nil.
    public var strong: Strong<T>? {
        switch self {
        case .weakReference, .unownedReference:
            return nil
        case .strongReference(let container):
            return container
        }
    }


    /// Returns a `WeakOrUnownedOrStrong<T>` as a weak reference with the value.
    public static func weak(_ value: T) -> WeakOrUnownedOrStrong<T> {
        return .weakReference(Weak(value))
    }


    /// Returns a `WeakOrUnownedOrStrong<T>` as an unowned reference with the value.
    public static func unowned(_ value: T) -> WeakOrUnownedOrStrong<T> {
        return .unownedReference(Unowned(value))
    }


    /// Returns a `WeakOrUnownedOrStrong<T>` as a strong reference with the value.
    public static func strong(_ value: T) -> WeakOrUnownedOrStrong<T> {
        return .strongReference(Strong(value))
    }


    /// Returns a `WeakOrUnownedOrStrong<T>` as an empty weak reference.
    /// This is useful to verify how behave when a weak reference was released.
    public static func empty<T>() -> WeakOrUnownedOrStrong<T> {
        return .weakReference(Weak())
    }
}