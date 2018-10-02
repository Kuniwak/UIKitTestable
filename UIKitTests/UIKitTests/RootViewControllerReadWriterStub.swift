import UIKit
import UIKitTestable



public final class RootViewControllerReadWriterStub: RootViewControllerReadWriterProtocol {
    public var rootViewController: UIViewController?
    private var completion: (() -> Void)?


    public init(alwaysReturn rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }


    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        self.completion = completion
    }


    public func complete() {
        self.completion?()
    }
}



public final class RootViewControllerReadWriterSyncStub: RootViewControllerReadWriterProtocol {
    public var rootViewController: UIViewController?
    private var completion: (() -> Void)?


    public init(alwaysReturn rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }


    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        completion?()
    }
}



public final class RootViewControllerReadWriterAsyncStub: RootViewControllerReadWriterProtocol {
    public var rootViewController: UIViewController?
    private var completion: (() -> Void)?


    public init(alwaysReturn rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }


    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            completion?()
        }
    }
}



public final class RootViewControllerReadWriterNeverStub: RootViewControllerReadWriterProtocol {
    public var rootViewController: UIViewController?
    private var completion: (() -> Void)?


    public init(alwaysReturn rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }


    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {}
}
