import UIKit
import UIKitTestable



public final class UnownedPresentingViewControllerReaderStub: UnownedPresentingViewControllerReaderProtocol {
    public var presentingViewController: UIViewController


    public init(willReturn presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
}