import UIKit



/**
 A stub class for RootViewControllerWriter.
 This class is useful for ignoring assigning `UIWindow.rootViewController` for testing.

 The completion of `alter(to:UIViewController, completion:(() -> Void)?)` can be called when `complete()` is called.
 */
public class RootViewControllerWriterStub: RootViewControllerWriterProtocol {
    private var completion: (() -> Void)? = nil


    public init() {}


    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        self.completion = completion
    }


    public func complete() {
        self.completion?()
    }
}



/**
 A stub class for RootViewControllerWriter.
 This class is useful for ignoring assigning `UIWindow.rootViewController` for testing.

 The completion of `alter(to:UIViewController, completion:(() -> Void)?)` will be called synchronously.
 */
public class RootViewControllerWriterSyncStub: RootViewControllerWriterProtocol {
    public init() {}


    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        completion?()
    }
}



/**
 A stub class for RootViewControllerWriter.
 This class is useful for ignoring assigning `UIWindow.rootViewController` for testing.

 The completion of `alter(to:UIViewController, completion:(() -> Void)?)` will be called asynchronously.
 */
public class RootViewControllerWriterAsyncStub: RootViewControllerWriterProtocol {
    public init() {}


    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            completion?()
        }
    }
}



/**
 A stub class for RootViewControllerWriter.
 This class is useful for ignoring assigning `UIWindow.rootViewController` for testing.

 The completion of `alter(to:UIViewController, completion:(() -> Void)?)` will be never called.
 */
public class RootViewControllerWriterNeverStub: RootViewControllerWriterProtocol {
    public init() {}


    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {}
}
