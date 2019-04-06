import UIKit



public protocol PresentingViewControllerReaderProtocol {
    var presentingViewController: WeakOrUnowned<UIViewController> { get }
}



extension PresentingViewControllerReaderProtocol {
    /// Returns a stub that do nothing.
    public static func stub(
        willReturn presentingViewController: WeakOrUnowned<UIViewController> = .empty()
    ) -> PresentingViewControllerReaderStub {
        return PresentingViewControllerReaderStub(willReturn: presentingViewController)
    }
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