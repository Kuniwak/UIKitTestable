import UIKit



/**
 A type for wrapper classes of `UINavigationController#pushViewController(_:UIViewController, animated:Bool)`.
 */
public protocol NavigatorProtocol {
    /**
     Pushes a view controller onto the receiver’s stack and updates the display.
     This method behave like `UINavigationController#pushViewController(UIViewController, animated: Bool)`
     */
    func push(viewController: UIViewController, animated: Bool)
}



/**
 A wrapper class to encapsulate a implementation of `UINavigationController#pushViewController(UIViewController, animated: Bool)`.
 You can replace the class to the stub or spy for testing.
 */
public final class Navigator: NavigatorProtocol {
    private let navigationController: WeakOrUnowned<UINavigationController>


    /**
     Return newly initialized Navigator for the specified UINavigationController.
     You can push to the UINavigationController by calling the method `#navigate`.
     */
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
