import UIKit



/// A stub class for `Navigator`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// - SeeAlso: [`NavigatorUsages`](https://kuniwak.github.io/UIKitTestable/UIKitTestableAppTests/Classes/NavigatorUsages.html).
public final class NavigatorStub: NavigatorProtocol {
    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func push(viewController: UIViewController, animated: Bool) {}
}
