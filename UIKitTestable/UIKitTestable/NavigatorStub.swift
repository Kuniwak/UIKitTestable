import UIKit



/**
 A stub class for Navigator.
 This class is useful for ignoring calls of `UINavigationController#pushViewController` for testing.
 */
public class NavigatorStub: NavigatorProtocol {
    public init() {}


    public func navigate(to viewController: UIViewController, animated: Bool) {}
}