/// A class for strong references.
/// This class can be used to express how the value should be held.
public final class Strong<T: AnyObject> {
    /// The value pointed by the reference.
    public let value: T


    /// Initializes a strong container with the value.
    /// - parameters:
    ///     - value: The value held strongly.
    public init(_ value: T) {
        self.value = value
    }


    /// Does something with the value.
    /// - parameters:
    ///     - block: A function that take the value.
    public func `do`(_ block: (T) throws -> Void) rethrows {
        try block(self.value)
    }


    /// Returns the value as a strong reference.
    /// - parameters:
    ///     - value: The value held strongly.
    /// - returns: A new strong reference.
    public static func strong(_ value: T) -> Strong<T> {
        return Strong(value)
    }


    /// Returns the value as a weak reference.
    /// - returns: A new weak reference.
    public func asWeak() -> Weak<T> {
        return Weak(self.value)
    }


    /// Returns the value as an unowned reference.
    /// - returns: A new unowned reference.
    public func asUnowned() -> Unowned<T> {
        return Unowned(self.value)
    }
}
