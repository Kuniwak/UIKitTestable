import UIKit



/// A stub class for `ModalDismisser`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions can be called manually.
/// - SeeAlso: [`ModalDismisserUsages`](https://kuniwak.github.io/UIKitTestable/UIKitTestableAppTests/Classes/ModalDismisserUsages.html).
public final class ModalDismisserManualStub: ModalDismisserProtocol {
    /// The last completion if exists.
    public var completion: (() -> Void)!


    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func dismiss(animated: Bool) {}


    /// Does nothing but the completion can be called by calling `complete`.
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



/// A stub class for `ModalDismisser`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions will be called immediately.
/// - SeeAlso: [`ModalDismisserUsages`](https://kuniwak.github.io/UIKitTestable/UIKitTestableAppTests/Classes/ModalDismisserUsages.html).
public final class ModalDismisserSyncStub: ModalDismisserProtocol {
    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func dismiss(animated: Bool) {}


    /// Does nothing but the completion will be called immediately.
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
}



/// A stub class for `ModalDismisser`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions will be called asynchronously.
/// - SeeAlso: [`ModalDismisserUsages`](https://kuniwak.github.io/UIKitTestable/UIKitTestableAppTests/Classes/ModalDismisserUsages.html).
public final class ModalDismisserAsyncStub: ModalDismisserProtocol {
    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func dismiss(animated: Bool) {}


    /// Does nothing but the completion will be called asynchronously.
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            completion?()
        }
    }
}



/// A stub class for `ModalDismisser`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions will be never called.
/// - SeeAlso: [`ModalDismisserUsages`](https://kuniwak.github.io/UIKitTestable/UIKitTestableAppTests/Classes/ModalDismisserUsages.html).
public final class ModalDismisserNeverStub: ModalDismisserProtocol {
    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func dismiss(animated: Bool) {}


    /// Does nothing and the completion will be never called.
    public func dismiss(animated: Bool, completion: (() -> Void)?) {}
}
