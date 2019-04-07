import UIKit



/// A spy class for `RootViewControllerWriter`s.
/// This class is useful for capturing assigning `UIWindow.rootViewController` for testing.
public final class RootViewControllerWriterSpy: RootViewControllerWriterProtocol {
    /// Call arguments of methods of `RootViewControllerWriterSpy`.
    public enum CallArgs: Equatable {
        case alter(rootViewController: UIViewController)
    }


    /// Captured call arguments list for methods.
    /// You can use the property to verify how methods were called.
    public private(set) var callArgs: [CallArgs] = []


    /// A dynamic base class that can control how the last completion is called.
    public var inherited: RootViewControllerWriterProtocol


    /// Returns a newly initialized spy.`
    /// - Parameters:
    ///     - inherited: A dynamic base class that can control how the last completion is called.
    public init(inheriting inherited: RootViewControllerWriterProtocol = RootViewControllerWriterNeverStub()) {
        self.inherited = inherited
    }


    /// Records the call arguments and calls the dynamic base class.
    public func alter(to rootViewController: UIViewController) {
        self.alter(to: rootViewController, completion: nil)
    }


    /// Records the call arguments and calls the dynamic base class.
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        self.callArgs.append(.alter(rootViewController: rootViewController))
        self.inherited.alter(to: rootViewController, completion: completion)
    }
}
