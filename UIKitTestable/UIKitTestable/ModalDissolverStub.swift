import UIKit



/// A stub class for `ModalDissolver`.
/// This class is useful to prevent side-effects for testing.
/// Given completions can be called manually.
public final class ModalDissolverManualStub: ModalDissolverProtocol {
    /// The last completion if exists.
    public var completion: (() -> Void)!


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



/// A stub class for `ModalDissolver`.
/// This class is useful to prevent side-effects for testing.
/// Given completions will be called immediately.
public final class ModalDissolverSyncStub: ModalDissolverProtocol {
    public init() {}


    /// Does nothing.
    public func dismiss(animated: Bool) {}


    /// Does nothing but the completion will be called immediately.
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
}



/// A stub class for `ModalDissolver`.
/// This class is useful to prevent side-effects for testing.
/// Given completions will be called asynchronously.
public final class ModalDissolverAsyncStub: ModalDissolverProtocol {
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



/// A stub class for `ModalDissolver`.
/// This class is useful to prevent side-effects for testing.
/// Given completions will be never called.
public final class ModalDissolverNeverStub: ModalDissolverProtocol {
    public init() {}


    /// Does nothing.
    public func dismiss(animated: Bool) {}


    /// Does nothing and the completion will be never called.
    public func dismiss(animated: Bool, completion: (() -> Void)?) {}
}
