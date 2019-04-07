import UIKit



/// A protocol for wrapper class that encapsulate a getter for `UIViewController.presentingViewController`.
/// You can use some stubs or spies instead of actual classes for testing.
/// - SeeAlso: `PresentingViewControllerReaderUsages`.
public protocol PresentingViewControllerReaderProtocol {
    /// The view controller that presented this view controller.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621430-presentingviewcontroller#)
    var presentingViewController: WeakOrUnowned<UIViewController> { get }
}



/// Returns a stub that do nothing.
public func stub(
    willReturn presentingViewController: WeakOrUnowned<UIViewController> = .empty()
) -> PresentingViewControllerReaderStub {
    return PresentingViewControllerReaderStub(willReturn: presentingViewController)
}



/// A protocol for wrapper class that encapsulate a getter for `UIViewController.presentingViewController`.
/// You can replace the class with a stub or spy for testing.
/// - SeeAlso: `PresentingViewControllerReaderUsages`.
public final class PresentingViewControllerReader: PresentingViewControllerReaderProtocol {
    private let viewController: WeakOrUnowned<UIViewController>


    /// - Parameters:
    ///     - viewController: The view controller presenting some view controllers.
    public init(presentedBy viewController: WeakOrUnowned<UIViewController>) {
        self.viewController = viewController
    }


    /// The view controller that presented this view controller.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621430-presentingviewcontroller#)
    public var presentingViewController: WeakOrUnowned<UIViewController> {
        return self.viewController
    }
}