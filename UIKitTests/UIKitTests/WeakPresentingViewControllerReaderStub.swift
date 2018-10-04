import UIKit
import UIKitTestable



public final class WeakPresentingViewControllerReaderStub: WeakPresentingViewControllerReaderProtocol {
    // NOTE: This reference can make memory leaks but it should not be a weak reference.
    //       Because tests can be failed caused by unexpected releasing.
    public var presentingViewController: UIViewController?


    public init(willReturn presentingViewController: UIViewController?) {
        self.presentingViewController = presentingViewController
    }
}