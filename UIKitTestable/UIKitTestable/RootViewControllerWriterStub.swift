import UIKit



/// A stub class for `RootViewControllerWriter`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions can be called manually.
/// - SeeAlso: `RootViewControllerWriterUsages`.
public final class RootViewControllerWriterManualStub: RootViewControllerWriterProtocol {
    /// The last completion.
    private var completion: (() -> Void)?


    /// Returns a newly initialized stub.`
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



/// A stub class for `RootViewControllerWriter`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions will be called immediately.
/// - SeeAlso: `RootViewControllerWriterUsages`.
public final class RootViewControllerWriterSyncStub: RootViewControllerWriterProtocol {
    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func alter(to rootViewController: UIViewController) {}


    /// Does nothing but the completion will be called immediately.
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        completion?()
    }
}



/// A stub class for `RootViewControllerWriter`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions will be called asynchronously.
/// - SeeAlso: `RootViewControllerWriterUsages`.
public final class RootViewControllerWriterAsyncStub: RootViewControllerWriterProtocol {
    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func alter(to rootViewController: UIViewController) {}


    /// Does nothing but the completion will be called asynchronously.
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            completion?()
        }
    }
}



/// A stub class for `RootViewControllerWriter`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions will be never called.
/// - SeeAlso: `RootViewControllerWriterUsages`.
public final class RootViewControllerWriterNeverStub: RootViewControllerWriterProtocol {
    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func alter(to rootViewController: UIViewController) {}


    /// Does nothing but the completion will be never called.
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {}
}
