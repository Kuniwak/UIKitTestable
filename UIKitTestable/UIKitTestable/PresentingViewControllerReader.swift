import UIKit



public protocol PresentingViewControllerReaderProtocol {
    var presentingViewController: WeakOrUnowned<UIViewController> { get }
}



public final class PresentingViewControllerReader: PresentingViewControllerReaderProtocol {
    private let viewController: WeakOrUnowned<UIViewController>


    public init(presentedBy viewController: WeakOrUnowned<UIViewController>) {
        self.viewController = viewController
    }


    public var presentingViewController: WeakOrUnowned<UIViewController> {
        return self.viewController
    }
}