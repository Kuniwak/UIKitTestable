import UIKit
import UIKitTestable



/**
 A stub class for Navigator.
 This class is useful for ignoring calls of `UINavigationController#pushViewController` for testing.
 */
public final class NavigatorStub: NavigatorProtocol {
    public init() {}


    public func navigate(to viewController: UIViewController, animated: Bool) {}
}