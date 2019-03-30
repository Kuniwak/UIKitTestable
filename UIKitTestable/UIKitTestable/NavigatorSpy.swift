import UIKit



/**
 A spy class for Navigator.
 This class is useful for capturing calls of `UINavigationController#pushViewController` for testing.
 */
public final class NavigatorSpy: NavigatorProtocol {
    public enum CallArgs: Equatable {
        case push(viewController: UIViewController, animated: Bool)
    }


    /**
     Call arguments list for the method `#navigate(to viewController: UIViewController, animated: Bool)`.
     You can use the property to test how the method is called.
     */
    public private(set) var callArgs: [CallArgs] = []


    public var delegate: NavigatorProtocol


    public init(delegating delegate: NavigatorProtocol = NavigatorStub()) {
        self.delegate = delegate
    }


    public func push(viewController: UIViewController, animated: Bool) {
        self.callArgs.append(.push(viewController: viewController, animated: animated))

        self.delegate.push(viewController: viewController, animated: animated)
    }
}
