import UIKit



public protocol WeakPresentingViewControllerReaderProtocol {
    var presentingViewController: UIViewController? { get }
}



public final class WeakPresentingViewControllerReader: WeakPresentingViewControllerReaderProtocol {
    private weak var viewController: UIViewController?


    public init(presentedBy viewController: UIViewController) {
        self.viewController = viewController
    }


    public var presentingViewController: UIViewController? {
        return viewController
    }
}