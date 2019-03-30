import UIKit



/**
 A stub class for Navigator.
 This class is useful for ignoring calls of `UINavigationController#pushViewController` for testing.
 */
public final class NavigatorStub: NavigatorProtocol {
    public init() {}


    public func push(viewController: UIViewController, animated: Bool) {}
}
