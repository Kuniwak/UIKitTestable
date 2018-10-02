import UIKit
import UIKitTestable



public final class RootViewControllerReadWriterSpy: RootViewControllerReadWriterProtocol {
    public enum CallArgs: Equatable {
        case rootViewController
        case alter(rootViewController: UIViewController)
    }


    public private(set) var callArgs = [CallArgs]()
    public var delegate: RootViewControllerReadWriterProtocol


    public var rootViewController: UIViewController? {
        self.callArgs.append(.rootViewController)

        return self.delegate.rootViewController
    }


    public init(delegating delegate: RootViewControllerReadWriterProtocol) {
        self.delegate = delegate
    }


    public func alter(to rootViewController: UIViewController) {
        self.delegate.alter(to: rootViewController, completion: nil)
    }


    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        self.callArgs.append(.alter(rootViewController: rootViewController))

        self.delegate.alter(to: rootViewController)
    }
}