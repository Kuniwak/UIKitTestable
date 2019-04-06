import UIKit



/// A stub class for `PresentingViewControllerReader`.
/// This class is useful to prevent side-effects for testing.
public final class PresentingViewControllerReaderStub: PresentingViewControllerReaderProtocol {
    public var presentingViewController: WeakOrUnowned<UIViewController>


    /// - parameters:
    ///     - presentingViewController: An UIViewController that will be returned by the stub.
    public init(
        willReturn presentingViewController: WeakOrUnowned<UIViewController> = .empty()
    ) {
        self.presentingViewController = presentingViewController
    }
}
