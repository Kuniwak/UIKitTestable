import UIKit



/// A stub class for `PresentingViewControllerReader`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// - SeeAlso: `PresentingViewControllerReaderUsages`.
public final class PresentingViewControllerReaderStub: PresentingViewControllerReaderProtocol {
    public var presentingViewController: WeakOrUnowned<UIViewController>


    /// Returns a newly initialized stub.`
    /// - Parameters:
    ///     - presentingViewController: An UIViewController that will be returned by the stub.
    public init(
        willReturn presentingViewController: WeakOrUnowned<UIViewController> = .empty()
    ) {
        self.presentingViewController = presentingViewController
    }
}
