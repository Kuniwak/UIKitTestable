import UIKit



/// A stub class for `ModalPresenter`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions can be called manually.
/// - SeeAlso: `ModalPresenterUsages`.
public final class ModalPresenterManualStub: ModalPresenterProtocol {
    /// The last completion if exists.
    private var completion: (() -> Void)!


    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func present(viewController: UIViewController, animated: Bool) {}


    /// Does nothing but the completion can be called by calling `complete`.
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
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



/// A stub class for `ModalPresenter`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions will be called immediately.
/// - SeeAlso: `ModalPresenterUsages`.
public final class ModalPresenterSyncStub: ModalPresenterProtocol {
    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func present(viewController: UIViewController, animated: Bool) {}


    /// Does nothing but the completion will be called immediately.
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
}



/// A stub class for `ModalPresenter`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions will be called asynchronously.
/// - SeeAlso: `ModalPresenterUsages`.
public final class ModalPresenterAsyncStub: ModalPresenterProtocol {
    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func present(viewController: UIViewController, animated: Bool) {}


    /// Does nothing but the completion will be called asynchronously.
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            completion?()
        }
    }
}



/// A stub class for `ModalPresenter`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions will be never called.
/// - SeeAlso: `ModalPresenterUsages`.
public final class ModalPresenterNeverStub: ModalPresenterProtocol {
    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func present(viewController: UIViewController, animated: Bool) {}


    /// Does nothing but the completion will be never called.
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {}
}
