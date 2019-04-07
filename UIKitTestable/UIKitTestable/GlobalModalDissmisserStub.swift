import UIKit



/// A stub class for `GlobalModalDismisser`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions can be called manually.
/// - SeeAlso: `GlobalModalDismisserUsages`.
public final class GlobalModalDismisserManualStub: GlobalModalDismisserProtocol {
    /// The last completion if exists.
    private var completion: (() -> Void)?


    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func dismiss(animated: Bool) {}


    /// Does nothing and the given completion will be not called but can call it by calling `complete`.
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
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



/// A stub class for `GlobalModalDismisser`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions will be called immediately.
/// - SeeAlso: `GlobalModalDismisserUsages`.
public final class GlobalModalDismisserSyncStub: GlobalModalDismisserProtocol {
    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func dismiss(animated: Bool) {}


    /// Does nothing but the completion will be called immediately.
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
}



/// A stub class for `GlobalModalDismisser`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions will be called asynchronously.
/// - SeeAlso: `GlobalModalDismisserUsages`.
public final class GlobalModalDismisserAsyncStub: GlobalModalDismisserProtocol {
    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func dismiss(animated: Bool) {}


    /// Does nothing but the completion will be call asynchronously.
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            completion?()
        }
    }
}


/// A stub class for `GlobalModalDismisser`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions will be never called.
/// - SeeAlso: `GlobalModalDismisserUsages`.
public final class GlobalModalDismisserNeverStub: GlobalModalDismisserProtocol {
    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func dismiss(animated: Bool) {}


    /// Does nothing and will never call the completion.
    public func dismiss(animated: Bool, completion: (() -> Void)?) {}
}
