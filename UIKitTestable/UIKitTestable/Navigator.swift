import UIKit



/// A type for wrapper classes of `UINavigationController#pushViewController(_:UIViewController, animated:Bool)`.
public protocol NavigatorProtocol {
    /// Pushes a view controller onto the receiver’s stack and updates the display.
    /// This method behave like `UINavigationController#pushViewController(UIViewController, animated: Bool)`
    func push(viewController: UIViewController, animated: Bool)
}



extension NavigatorProtocol {
    /// Returns a stub that do nothing.
    public static func stub() -> NavigatorStub {
        return NavigatorStub()
    }


    /// Returns a spy that record how methods were called.
    /// - parameters:
    ///     - inherited: A dynamic base class control how behave a method is called. Default is doing nothing.
    public static func spy(inheriting inherited: NavigatorProtocol = NavigatorStub()) -> NavigatorSpy {
        return NavigatorSpy(inheriting: inherited)
    }
}



/// A wrapper class to encapsulate a implementation of `UINavigationController#pushViewController(UIViewController, animated: Bool)`.
/// You can replace the class to the stub or spy for testing.
public final class Navigator: NavigatorProtocol {
    private let navigationController: WeakOrUnowned<UINavigationController>


    /// Initializes a new Navigator for the specified UINavigationController.
    /// You can push to the UINavigationController by calling `push(viewController: UIViewController, animated: Bool)`.
    public init(for navigationController: WeakOrUnowned<UINavigationController>) {
        self.navigationController = navigationController
    }


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
