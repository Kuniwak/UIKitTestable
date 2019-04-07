/// A class for weak references.
/// This class can be used to express how the value should be held.
public class Weak<T: AnyObject> {
    /// The value pointed by the reference if it is not released. Otherwise nil.
    public private(set) weak var value: T?


    /// Whether the value is released or not.
    public var isReleased: Bool {
        return self.value == nil
    }


    /// Returns a new weak reference with no values.
    /// This is useful to verify how behave when a weak reference was released.
    public init() {
        self.value = nil
    }


    /// Returns a new weak reference with the value.
    /// - Parameters:
    ///     - value: The value held weakly.
    public init(_ value: T) {
        self.value = value
    }


    /// Does something with the value.
    /// - Parameters:
    ///     - block: A function that take the value if the value is not released. Otherwise take a nil.
    public func `do`(_ block: (T?) throws -> Void) rethrows {
        try block(self.value)
    }


    /// Returns the value as a weak reference.
    /// - Parameters:
    ///     - value: The value held weakly.
    /// - Returns: A new weak reference.
    public static func weak(_ value: T) -> Weak<T> {
        return Weak(value)
    }


    /// Returns the value as an unowned reference.
    /// - Returns: An unowned reference.
    /// - throws: `InvalidAccessToReleasedWeakValue` if the weak value was released.
    public func asUnowned() throws -> Unowned<T> {
        guard let value = self.value else {
            throw InvalidAccessToReleasedWeakValue()
        }
        return Unowned(value)
    }


    /// Returns the value as a strong reference.
    /// - Returns: An unowned reference.
    /// - throws: `InvalidAccessToReleasedWeakValue` if the weak value was released.
    public func asStrong() throws -> Strong<T> {
        guard let value = self.value else {
            throw InvalidAccessToReleasedWeakValue()
        }
        return Strong(value)
    }
}
