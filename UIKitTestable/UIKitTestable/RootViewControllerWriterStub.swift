import UIKit



/// A stub class for `RootViewControllerWriter`.
/// This class is useful to prevent side-effects for testing.
public final class RootViewControllerWriterManualStub: RootViewControllerWriterProtocol {
    /// The last completion.
    private var completion: (() -> Void)?


    public init() {}


    /// Does nothing.
    public func alter(to rootViewController: UIViewController) {}


    /// Does nothing but the completion can be called by `complete`.
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        self.completion = completion
    }


    /// Calls the last completion if exists. Otherwise throws a NoSuchCompletions.
    /// - throws: NoSuchCompletions.
    public func complete() throws {
        guard let completion = self.completion else {
            throw NoSuchCompletions()
        }
        completion()
    }
}



/**
 A stub class for RootViewControllerWriter.
 This class is useful for ignoring assigning `UIWindow.rootViewController` for testing.

 The completion of `alter(to:UIViewController, completion:(() -> Void)?)` will be called synchronously.
 */
public final class RootViewControllerWriterSyncStub: RootViewControllerWriterProtocol {
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
public final class RootViewControllerWriterAsyncStub: RootViewControllerWriterProtocol {
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
public final class RootViewControllerWriterNeverStub: RootViewControllerWriterProtocol {
    public init() {}


    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {}
}
