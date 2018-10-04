import UIKit
import UIKitTestable



public final class PresentingViewControllerReaderStub: PresentingViewControllerReaderProtocol {
    public var presentingViewController: WeakOrUnowned<UIViewController>


    public init(willReturn presentingViewController: WeakOrUnowned<UIViewController>) {
        self.presentingViewController = presentingViewController
    }
}