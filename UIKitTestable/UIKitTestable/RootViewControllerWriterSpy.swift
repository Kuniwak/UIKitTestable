import UIKit



/**
 A spy class for RootViewControllerHolders.
 This class is useful for capturing assigning `UIWindow.rootViewController` for testing.
 */
public class RootViewControllerWriterSpy: RootViewControllerWriterProtocol {
    public enum CallArgs: Equatable {
        case alter(rootViewController: UIViewController)
    }


    /**
     Call arguments list for the method `#back(to rootViewController: UIViewController)`.
     You can use the property to test how the method is called.
     */
    public private(set) var callArgs: [CallArgs] = []

    public var delegate: RootViewControllerWriterProtocol


    public init(delegating delegate: RootViewControllerWriterProtocol = RootViewControllerWriterSyncStub()) {
        self.delegate = delegate
    }


    public func alter(to rootViewController: UIViewController) {
        self.alter(to: rootViewController, completion: nil)
    }


    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        self.callArgs.append(.alter(rootViewController: rootViewController))
        self.delegate.alter(to: rootViewController, completion: completion)
    }
}
