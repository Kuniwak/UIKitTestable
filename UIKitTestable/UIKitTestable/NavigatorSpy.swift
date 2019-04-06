import UIKit



/// A spy class for `Navigator`s.
/// This class captures calls of methods of the class for testing.
public final class NavigatorSpy: NavigatorProtocol {
    /// Call arguments of methods of `NavigatorSpy`.
    public enum CallArgs: Equatable {
        case push(viewController: UIViewController, animated: Bool)
    }


    /// Captured call arguments list for methods.
    /// You can use the property to test how methods were called.
    public private(set) var callArgs: [CallArgs] = []


    /// A dynamic base class that can control how behave.
    public var inherited: NavigatorProtocol


    /// - parameters:
    ///     - inherited: A dynamic base class that can control how behave. Default is doing nothing.
    public init(inheriting inherited: NavigatorProtocol = NavigatorStub()) {
        self.inherited = inherited
    }


    /// Records the call arguments and calls the dynamic base class.
    public func push(viewController: UIViewController, animated: Bool) {
        self.callArgs.append(.push(viewController: viewController, animated: animated))

        self.inherited.push(viewController: viewController, animated: animated)
    }
}
