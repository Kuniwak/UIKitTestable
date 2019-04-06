/// A class for weak or unowned references.
/// This class can be used to users can determine how the value should be held.
public enum WeakOrUnowned<T: AnyObject> {
    /// A case for weak references.
    case weakReference(Weak<T>)
    /// A case for unowned references.
    case unownedReference(Unowned<T>)


    /// Returns a weak reference if this is a weak reference. Otherwise nil.
    /// - returns: A weak reference if this is a weak reference. Otherwise nil.
    public var weak: Weak<T>? {
        switch self {
        case .weakReference(let container):
            return container
        case .unownedReference:
            return nil
        }
    }


    /// Returns an unowned reference if this is an unowned reference. Otherwise nil.
    /// - returns: An unowned reference if this is an unowned reference. Otherwise nil.
    public var unowned: Unowned<T>? {
        switch self {
        case .weakReference:
            return nil
        case .unownedReference(let container):
            return container
        }
    }


    /// Returns `WeakOrUnowned<T>` as a weak reference.
    public static func weak(_ value: T) -> WeakOrUnowned<T> {
        return .weakReference(Weak(value))
    }


    /// Returns `WeakOrUnowned<T>` as an unowned reference.
    public static func unowned(_ value: T) -> WeakOrUnowned<T> {
        return .unownedReference(Unowned(value))
    }


    /// Returns `WeakOrUnowned<T>` as an empty weak reference.
    /// This is useful to verify how behave when a weak reference was released.
    public static func empty() -> WeakOrUnowned<T> {
        return .weakReference(Weak<T>())
    }
}
