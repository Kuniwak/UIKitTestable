import UIKit


public protocol UnownedPresentingViewControllerReaderProtocol {
    var presentingViewController: UIViewController { get }
}



public final class UnownedPresentingViewControllerReader: UnownedPresentingViewControllerReaderProtocol {
    private unowned var viewController: UIViewController


    public init(presentedByAndUnowned viewController: UIViewController) {
        self.viewController = viewController
    }


    public var presentingViewController: UIViewController {
        return viewController
    }
}
