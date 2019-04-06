import UIKit



/// A stub class for `GlobalModalDissolver`.
/// This class is useful to prevent side-effects for testing.
/// Given completions can be called manually.
public final class GlobalModalDissolverManualStub: GlobalModalDissolverProtocol {
    /// The last completion if exists.
    private var completion: (() -> Void)?


    public init() {}


    /// Do nothing.
    public func dismiss(animated: Bool) {}


    /// Do nothing and the given completion will be not called but can call it by calling `complete`.
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.completion = completion
    }


    /// Call the latest completion callback.
    public func complete() {
        self.completion?()
    }
}



/// A stub class for `GlobalModalDissolver`.
/// This class is useful to prevent side-effects for testing.
/// Given completions will be called immediately.
public final class GlobalModalDissolverSyncStub: GlobalModalDissolverProtocol {
    public init() {}


    /// Do nothing.
    public func dismiss(animated: Bool) {}


    /// Do nothing but call the completion immediately.
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
}



/// A stub class for `GlobalModalDissolver`.
/// This class is useful to prevent side-effects for testing.
/// Given completions will be called asynchronously.
public final class GlobalModalDissolverAsyncStub: GlobalModalDissolverProtocol {
    public init() {}


    /// Do nothing.
    public func dismiss(animated: Bool) {}


    /// Do nothing but call the completion asynchronously.
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            completion?()
        }
    }
}


/// A stub class for `GlobalModalDissolver`.
/// This class is useful to prevent side-effects for testing.
/// Given completions will be never called.
public final class GlobalModalDissolverNeverStub: GlobalModalDissolverProtocol {
    public init() {}


    /// Do nothing.
    public func dismiss(animated: Bool) {}


    /// Do nothing and will never call the completion.
    public func dismiss(animated: Bool, completion: (() -> Void)?) {}
}
