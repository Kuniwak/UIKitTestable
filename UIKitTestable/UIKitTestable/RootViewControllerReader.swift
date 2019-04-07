import UIKit



/// A protocol for wrapper classes that encapsulate a getter of rootViewController.
/// You can use some stubs or spies instead of actual classes for testing.
public protocol RootViewControllerReaderProtocol: AnyObject {
    /// The root view controller.
    var rootViewController: UIViewController? { get }
}



/// Returns a stub that always return the specified view controllers.
public func stub(
    willReturn viewController: WeakOrUnownedOrStrong<UIViewController> = .empty()
) -> RootViewControllerReaderStub {
    return RootViewControllerReaderStub(willReturn: viewController)
}



/// A protocol for wrapper classes that encapsulate a getter of rootViewController.
/// You can use some stubs or spies instead of actual classes for testing.
public final class WindowRootViewControllerReader: RootViewControllerReaderProtocol {
    private let window: WeakOrUnowned<UIWindow>


    /// The root view controller of the window.
    /// - Returns: The root view controller of the window.
    public var rootViewController: UIViewController? {
        switch self.window {
        case .weakReference(let weak):
            return weak.value?.rootViewController

        case .unownedReference(let unowned):
            return unowned.value.rootViewController
        }
    }


    /// Returns a newly initialized `WindowsRootViewControllerReader`.
    /// - Parameters:
    ///     - window: The window who have a rootViewController.
    public init(whoHaveRootViewController window: WeakOrUnowned<UIWindow>) {
        self.window = window
    }
}
