import UIKit



/**
 A spy class for Navigator.
 This class is useful for capturing calls of `UINavigationController#pushViewController` for testing.
 */
public class NavigatorSpy: NavigatorProtocol {
    public typealias CallArgs = (viewController: UIViewController, animated: Bool)


    /**
     Call arguments list for the method `#navigate(to viewController: UIViewController, animated: Bool)`.
     You can use the property to test how the method is called.
     */
    public fileprivate(set) var callArgs: [CallArgs] = []


    public var delegate: NavigatorProtocol


    public init(delegating delegate: NavigatorProtocol = NavigatorStub()) {
        self.delegate = delegate
    }


    public func navigate(to viewController: UIViewController, animated: Bool) {
        let callArgs = (viewController: viewController, animated: animated)
        self.callArgs.append(callArgs)

        self.delegate.navigate(to: viewController, animated: animated)
    }
}
