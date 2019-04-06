import UIKit



/// A spy class for `ReverseNavigators`.
/// This class captures calls of methods of the class for testing.
public final class ReverseNavigatorSpy: ReverseNavigatorProtocol {
    /// Call arguments of methods of the class.
    public enum CallArgs: Equatable {
        case back(animated: Bool)
    }


    /// Captured call arguments list for methods.
    /// You can use the property to verify how methods were called.
    public private(set) var callArgs: [CallArgs] = []


    /// A dynamic base class that can control how behave.
    public var inherited: ReverseNavigatorProtocol


    /// - parameters:
    ///     - inherited: A dynamic base class that can control how behave. Default is doing nothing.
    public init(inheriting inherited: ReverseNavigatorProtocol = ReverseNavigatorStub()) {
        self.inherited = inherited
    }


    /// Records the call arguments and calls the dynamic base class.
    public func pop(animated: Bool) throws {
        self.callArgs.append(.back(animated: animated))

        try self.inherited.pop(animated: animated)
    }
}
