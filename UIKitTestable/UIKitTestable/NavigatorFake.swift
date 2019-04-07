import UIKit



/// A fake class for `Navigator`s.
/// This class behave like `UINavigationController` at somewhere.
public final class NavigatorFake: NavigatorProtocol {
    private let globalPresenter: GlobalModalPresenterProtocol
    private let globalDismisser: GlobalModalDismisserProtocol
    private let strongNavigationController: UINavigationController


    /// Returns a navigation controller.
    /// - Returns: A UINavigationController.
    public var navigationController: Weak<UINavigationController> {
        return Weak(self.strongNavigationController)
    }


    /// Returns a newly initialized fake.
    /// - Parameters:
    ///     - globalPresenter:
    public init(
        presentingBy globalPresenter: GlobalModalPresenterProtocol,
        dismissingBy globalDismisser: GlobalModalDismisserProtocol
    ) {
        self.globalPresenter = globalPresenter
        self.globalDismisser = globalDismisser
        self.strongNavigationController = UINavigationController(rootViewController: UIViewController())
    }


    /// Pushes a view controller onto the receiver’s stack and updates the display.
    /// This method behave like `UINavigationController#pushViewController(UIViewController, animated: Bool)`
    public func push(viewController: UIViewController, animated: Bool) {
        self.globalPresenter.present(
            viewController: self.strongNavigationController,
            animated: animated,
            completion: nil
        )
    }


    /// Disposes the navigation stack.
    public func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        self.globalDismisser.dismiss(animated: animated, completion: completion)
    }
}
