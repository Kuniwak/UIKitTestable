import UIKit



public class TestNavigator: NavigatorProtocol {
    private let rootViewControllerHolder: RootViewControllerHolderProtocol


    public init(
        alteringRootViewControllerBy rootViewControllerHolder: RootViewControllerHolderProtocol
    ) {
        self.rootViewControllerHolder = rootViewControllerHolder
    }


    public func navigate(to viewController: UIViewController, animated: Bool) {
        let navigationController = UINavigationController(
            rootViewController: viewController
        )
        self.rootViewControllerHolder.alter(to: navigationController)
    }
}
