import UIKit



/// A spy class for `GlobalModalPresenter`.
/// This class captures calls of methods of the class for testing.
public final class GlobalModalPresenterSpy: GlobalModalPresenterProtocol {
    /// Call arguments of methods of the class.
    public enum CallArgs: Equatable {
        case present(viewController: UIViewController, animated: Bool)
    }


    /// Call arguments list for the method `GlobalModalPresenter#present`.
    /// You can use the property to verify how the method is called.
    public private(set) var callArgs: [CallArgs] = []


    /// A dynamic base class that can control how the last completion is called.
    public var inherited: GlobalModalPresenterProtocol


    /// - parameters:
    ///     - inherited: A base class that can control when the last completion is called.
    public init(inheriting inherited: GlobalModalPresenterProtocol = GlobalModalPresenterNeverStub()) {
        self.inherited = inherited
    }


    /// Records the call arguments and calls the dynamic base class.
    public func present(
        viewController: UIViewController,
        animated: Bool
    ) {
        self.present(
            viewController: viewController,
            animated: animated,
            completion: nil
        )
    }


    /// Records the call arguments and calls the dynamic base class.
    public func present(
        viewController: UIViewController,
        animated: Bool,
        completion: (() -> Void)?
    ) {
        self.callArgs.append(.present(
            viewController: viewController,
            animated: animated
        ))

        self.inherited.present(
            viewController: viewController,
            animated: animated,
            completion: completion
        )
    }
}
