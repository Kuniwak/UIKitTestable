import UIKit



/**
 A type for wrapper classes of `UINavigationController#(_:UIViewController, animated:Bool)`.
 */
public protocol ReverseNavigatorProtocol {
    /**
     Pops view controllers until the specified view controller is at the top of the navigation stack.
     This method behave like `UINavigationController#popToViewController(UIVIewController, animated: Bool)`

     - throws: ReverseNavigatorError will be thrown when the UIViewController is not in the navigation stack.
     */
    func pop(animated: Bool) throws
}



/**
 A type for errors that can be thrown when `UINavigationController#popToViewController(UIVIewController, animated: Bool)`.
 */
public enum ReverseNavigatorError: Error {
    case noSuchDestinationViewControllerInNavigationStack(debugInfo: String)


    public static func noSuchDestinationViewControllerInNavigationStack(
        navigationController: UINavigationController,
        destinationViewController: UIViewController
    ) -> ReverseNavigatorError {
        let debugInfo = """
                        The Navigation stack of \(info(of: navigationController)) is:

                        \(dump(viewControllers: navigationController.viewControllers))
                        """

        return .noSuchDestinationViewControllerInNavigationStack(debugInfo: debugInfo)
    }
}



/**
 A wrapper class to encapsulate a implementation of `UINavigationController#popToViewController(UIViewController, animated: Bool)`.
 You can replace the class to the stub or spy for testing.
 */
public final class ReverseNavigator: ReverseNavigatorProtocol {
    private let navigationController: WeakOrUnowned<UINavigationController>
    private let destinationViewController: WeakOrUnowned<UIViewController>


    /**
     Return newly initialized Navigator for the specified UINavigationController.
     You can pop to the UIViewController by calling the method `#back`.
     */
    public init(
        willPopTo destinationViewController: WeakOrUnowned<UIViewController>,
        on navigationController: WeakOrUnowned<UINavigationController>
    ) {
        self.destinationViewController = destinationViewController
        self.navigationController = navigationController
    }


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
            throw ReverseNavigatorError.noSuchDestinationViewControllerInNavigationStack(
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
