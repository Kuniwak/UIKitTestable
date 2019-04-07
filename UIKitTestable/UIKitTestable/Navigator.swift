import UIKit



/// A protocol for wrapper classes that encapsulate `UINavigationController#pushViewController(_:UIViewController, animated:Bool)`.
/// You can use some stubs or spies instead of actual classes for testing.
/// - SeeAlso: [`NavigatorUsages`](https://kuniwak.github.io/UIKitTestable/UIKitTestableAppTests/Classes/NavigatorUsages.html).
public protocol NavigatorProtocol {
    /// Pushes a view controller onto the receiver’s stack and updates the display.
    /// This method behave like `UINavigationController#pushViewController(UIViewController, animated: Bool)`
    func push(viewController: UIViewController, animated: Bool)
}



/// Returns a stub that do nothing.
public func stub() -> NavigatorStub {
    return NavigatorStub()
}



/// A wrapper class to encapsulate a implementation of `UINavigationController#pushViewController(UIViewController, animated: Bool)`.
/// You can replace the class with the stub or spy for testing.
/// - SeeAlso: [`NavigatorUsages`](https://kuniwak.github.io/UIKitTestable/UIKitTestableAppTests/Classes/NavigatorUsages.html).
public final class Navigator: NavigatorProtocol {
    private let navigationController: WeakOrUnowned<UINavigationController>


    /// Initializes a new Navigator for the specified UINavigationController.
    /// You can push to the UINavigationController by calling `push(viewController: UIViewController, animated: Bool)`.
    public init(for navigationController: WeakOrUnowned<UINavigationController>) {
        self.navigationController = navigationController
    }


    /// Pushes a view controller onto the receiver’s stack and updates the display.
    /// This method behave like `UINavigationController#pushViewController(UIViewController, animated: Bool)`
    public func push(viewController: UIViewController, animated: Bool) {
        switch self.navigationController {
        case .weakReference(let weak):
            weak.do { navigationController in
                navigationController?.pushViewController(
                    viewController,
                    animated: animated
                )
            }

        case .unownedReference(let unowned):
            unowned.do { navigationController in
                navigationController.pushViewController(
                    viewController,
                    animated: animated
                )
            }
        }
    }
}
