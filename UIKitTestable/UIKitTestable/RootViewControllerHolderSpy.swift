import UIKit



/**
 A spy class for RootViewControllerHolders.
 This class is useful for capturing assigning `UIWindow.rootViewController` for testing.
 */
public class RootViewControllerHolderSpy: RootViewControllerHolderProtocol {
    public typealias CallArgs = UIViewController


    /**
     Call arguments list for the method `#back(to rootViewController: UIViewController)`.
     You can use the property to test how the method is called.
     */
    public fileprivate(set) var callArgs: [CallArgs] = []

    public var delegate: RootViewControllerHolderProtocol


    public init(delegating delegate: RootViewControllerHolderProtocol = RootViewControllerHolderStub()) {
        self.delegate = delegate
    }


    public func alter(to rootViewController: UIViewController) {
        self.callArgs.append(rootViewController)
        self.delegate.alter(to: rootViewController)
    }
}
