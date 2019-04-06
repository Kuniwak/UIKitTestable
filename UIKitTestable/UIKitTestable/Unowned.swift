/// A class for unowned references.
/// This class can be used to express how the value should be held.
public final class Unowned<T: AnyObject> {
    /// The value pointed by the reference.
    public private(set) unowned var value: T


    /// Returns a new unowned reference with the value.
    /// - parameters:
    ///     - value: The value held weakly but it must not be released until the reference is removed.
    public init(_ value: T) {
        self.value = value
    }


    /// Does something with the value.
    /// - parameters:
    ///     - block: A function that take the value.
    public func `do`(_ block: (T) throws -> Void) rethrows {
        try block(self.value)
    }


    /// Returns the value as an unowned reference.
    /// - parameters:
    ///     - value: The value held weakly but it must not be released until the reference is removed.
    /// - returns: A new unowned reference.
    public static func unowned(_ value: T) -> Unowned<T> {
        return Unowned(value)
    }


    /// Returns the value as a weak reference.
    /// - returns: A weak reference.
    public func asWeak() -> Weak<T> {
        return Weak(self.value)
    }


    /// Returns the value as a strong reference.
    /// - returns: A strong reference.
    public func asStrong() -> Strong<T> {
        return Strong(self.value)
    }
}
