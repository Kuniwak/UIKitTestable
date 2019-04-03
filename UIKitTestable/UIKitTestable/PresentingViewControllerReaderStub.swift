import UIKit



public final class PresentingViewControllerReaderStub: PresentingViewControllerReaderProtocol {
    public var presentingViewController: WeakOrUnowned<UIViewController>


    public init(
        willReturn presentingViewController: WeakOrUnowned<UIViewController> = .empty()
    ) {
        self.presentingViewController = presentingViewController
    }
}
