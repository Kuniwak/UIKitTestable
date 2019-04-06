import UIKit



/// A stub class for `ModalDissolver`.
/// This class is useful to prevent side-effects for testing.
public final class NavigatorStub: NavigatorProtocol {
    public init() {}


    /// Does nothing.
    public func push(viewController: UIViewController, animated: Bool) {}
}
