import UIKit



/// A type for wrapper classes of `UINavigationController#(_:UIViewController, animated:Bool)`.
/// You can use some stubs or spies instead of actual classes for testing.
/// - SeeAlso: [`ReverseNavigatorUsages`](https://kuniwak.github.io/UIKitTestable/UIKitTestableAppTests/Classes/ReverseNavigatorUsages.html).
public protocol ReverseNavigatorProtocol {
    /// Pops all the view controllers on the stack except the root view controller and updates the display.
    /// - Throws: Throws when the UIViewController is not in the navigation stack.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uinavigationcontroller/1621855-poptorootviewcontroller)
    func pop(animated: Bool) throws
}



/// Returns a stub that do nothing.
public func stub(willThrow error: NoSuchDestinationViewControllerInNavigationStack? = nil) -> ReverseNavigatorStub {
    return ReverseNavigatorStub(willThrow: error)
}



/// A wrapper class to encapsulate a implementation of `UINavigationController.popToViewController`.
/// You can replace the class with a stub or spy for testing.
/// - SeeAlso: [`ReverseNavigatorUsages`](https://kuniwak.github.io/UIKitTestable/UIKitTestableAppTests/Classes/ReverseNavigatorUsages.html).
public final class ReverseNavigator: ReverseNavigatorProtocol {
    private let navigationController: WeakOrUnowned<UINavigationController>
    private let destinationViewController: WeakOrUnowned<UIViewController>


    /// Return newly initialized Navigator for the specified UINavigationController.
    /// You can pop to the UIViewController by calling `pop()`.
    /// - Parameters:
    ///     - destinationViewController: A view controller where pop to.
    ///     - navigationController: A navigation controller that managed.
    public init(
        willPopTo destinationViewController: WeakOrUnowned<UIViewController>,
        on navigationController: WeakOrUnowned<UINavigationController>
    ) {
        self.destinationViewController = destinationViewController
        self.navigationController = navigationController
    }


    /// Pops all the view controllers on the stack except the root view controller and updates the display.
    /// - Throws: Throws when the UIViewController is not in the navigation stack.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uinavigationcontroller/1621855-poptorootviewcontroller)
    public func pop(animated: Bool) throws {
        switch self.navigationController {
        case .weakReference(let weakNav):
            try weakNav.do { navigationController in
                guard let navigationController = navigationController else { return }
                try self.pop(on: navigationController, animated: animated)
            }

        case .unownedReference(let unowned):
            try unowned.do { navigationController in
                try self.pop(on: navigationController, animated: animated)
            }
        }

    }


    private func pop(on navigationController: UINavigationController, animated: Bool) throws {
        switch self.destinationViewController {
        case .weakReference(let weak):
            try weak.do { destinationViewController in
                guard let destinationViewController = destinationViewController else { return }
                try self.pop(on: navigationController, to: destinationViewController, animated: animated)
            }

        case .unownedReference(let unowned):
            try unowned.do { destinationViewController in
                try self.pop(on: navigationController, to: destinationViewController, animated: animated)
            }
        }
    }


    private func pop(on navigationController: UINavigationController, to destinationViewController: UIViewController, animated: Bool) throws {
        guard navigationController.viewControllers.contains(destinationViewController) else {
            throw NoSuchDestinationViewControllerInNavigationStack(
                navigationController: navigationController,
                destinationViewController: destinationViewController
            )
        }

        navigationController.popToViewController(
            destinationViewController,
            animated: animated
        )
    }
}
