import UIKit



/// A spy class for `ModalPresenter`s.
/// This class captures calls of methods of the class for testing.
/// - SeeAlso: `ModalPresenterUsages`.
public final class ModalPresenterSpy: ModalPresenterProtocol {
    /// Call arguments of methods of `ModalPresenterSpy`.
    public enum CallArgs: Equatable {
        case present(viewController: UIViewController, animated: Bool)
    }


    /// Captured call arguments list for methods.
    /// You can use the property to verify how methods were called.
    public private(set) var callArgs: [CallArgs] = []


    /// A dynamic base class that can control how the last completion is called.
    public var inherited: ModalPresenterProtocol


    /// Returns a newly initialized spy.`
    /// - Parameters:
    ///     - inherited: A dynamic base class that can control how the last completion is called.
    public init(inheriting inherited: ModalPresenterProtocol = ModalPresenterNeverStub()) {
        self.inherited = inherited
    }


    /// Records the call arguments and calls the dynamic base class.
    public func present(viewController: UIViewController, animated: Bool) {
        self.callArgs.append(.present(viewController: viewController, animated: animated))

        self.inherited.present(viewController: viewController, animated: animated)
    }


    /// Records the call arguments and calls the dynamic base class.
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.callArgs.append(.present(viewController: viewController, animated: animated))

        self.inherited.present(viewController: viewController, animated: animated, completion: completion)
    }
}
