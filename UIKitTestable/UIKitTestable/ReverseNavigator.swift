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
    case noDestinationViewControllerInNavigationStack
}



/**
 A wrapper class to encapsulate a implementation of `UINavigationController#popToViewController(UIViewController, animated: Bool)`.
 You can replace the class to the stub or spy for testing.
 */
public class ReverseNavigator: ReverseNavigatorProtocol {
    private let navigationController: UINavigationController
    private let viewController: UIViewController


    /**
     Return newly initialized Navigator for the specified UINavigationController.
     You can pop to the UIViewController by calling the method `#back`.
     */
    public init(willPopTo viewController: UIViewController, on navigationController: UINavigationController) {
        self.viewController = viewController
        self.navigationController = navigationController
    }


    public func pop(animated: Bool) throws {
        guard self.navigationController.viewControllers.contains(self.viewController) else {
            throw ReverseNavigatorError.noDestinationViewControllerInNavigationStack
        }

        self.navigationController.popToViewController(
            self.viewController,
            animated: animated
        )
    }
}
