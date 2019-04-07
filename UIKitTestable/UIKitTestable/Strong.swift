/// A class for strong references.
/// This class can be used to express how the value should be held.
public final class Strong<T: AnyObject> {
    /// The value pointed by the reference.
    public let value: T


    /// Initializes a strong container with the value.
    /// - Parameters:
    ///     - value: The value held strongly.
    public init(_ value: T) {
        self.value = value
    }


    /// Does something with the value.
    /// - Parameters:
    ///     - block: A function that take the value.
    public func `do`(_ block: (T) throws -> Void) rethrows {
        try block(self.value)
    }


    /// Returns the value as a strong reference.
    /// - Parameters:
    ///     - value: The value held strongly.
    /// - Returns: A new strong reference.
    public static func strong(_ value: T) -> Strong<T> {
        return Strong(value)
    }


    /// Returns the value as a weak reference.
    /// - Returns: A new weak reference.
    public func asWeak() -> Weak<T> {
        return Weak(self.value)
    }


    /// Returns the value as an unowned reference.
    /// - Returns: A new unowned reference.
    public func asUnowned() -> Unowned<T> {
        return Unowned(self.value)
    }
}
