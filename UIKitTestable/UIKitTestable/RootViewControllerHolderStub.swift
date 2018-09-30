import UIKit



/**
 A stub class for RootViewControllerHolders.
 This class is useful for ignoring assigning `UIWindow.rootViewController` for testing.
 */
public class RootViewControllerHolderStub: RootViewControllerHolderProtocol {
    public init() {}


    public func alter(to rootViewController: UIViewController) {}
}
