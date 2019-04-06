import UIKit



/// A spy class for `RootViewControllerReadWriter`s.
/// This class captures calls of methods of the class for testing.
public final class RootViewControllerReadWriterSpy: RootViewControllerReadWriterProtocol {
    /// Call arguments of methods of `RootViewControllerReadWriterSpy`.
    public enum CallArgs: Equatable {
        case rootViewController
        case alter(rootViewController: UIViewController)
    }


    /// Captured call arguments list for methods.
    /// You can use the property to verify how methods were called.
    public private(set) var callArgs = [CallArgs]()


    /// A dynamic base class that can control how behave.
    public var inherited: RootViewControllerReadWriterProtocol


    public var rootViewController: UIViewController? {
        self.callArgs.append(.rootViewController)

        return self.inherited.rootViewController
    }


    /// - parameters:
    ///     - inherited: A dynamic base class that can control how behave.
    public init(inheriting inherited: RootViewControllerReadWriterProtocol = RootViewControllerReadWriterNeverStub()) {
        self.inherited = inherited
    }


    /// Records the call arguments and calls the dynamic base class.
    public func alter(to rootViewController: UIViewController) {
        self.callArgs.append(.alter(rootViewController: rootViewController))

        self.inherited.alter(to: rootViewController)
    }


    /// Records the call arguments and calls the dynamic base class.
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        self.callArgs.append(.alter(rootViewController: rootViewController))

        self.inherited.alter(to: rootViewController, completion: completion)
    }
}
