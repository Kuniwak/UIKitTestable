import UIKit



/// A stub class for ModalDissolvers.
/// This class is useful for ignoring calls of `UIViewController#dismiss` for testing.
///
/// The completion of `dismiss(animated:Bool, completion:(() -> Void)?)` can be called using `complete()`.
public final class ModalDissolverManualStub: ModalDissolverProtocol {
    /// The last completion if exists.
    public var completion: (() -> Void)?


    public init() {}


    public func dismiss(animated: Bool) {}
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.completion = completion
    }


    /// Call the last completion if exists.
    public func complete() {
        self.completion?()
    }
}



/// A stub class for ModalDissolvers.
/// This class is useful for ignoring calls of `UIViewController#dismiss` for testing.
///
/// The completion of `dismiss(animated:Bool, completion:(() -> Void)?)` will be called immediately.
public final class ModalDissolverSyncStub: ModalDissolverProtocol {
    public init() {}


    public func dismiss(animated: Bool) {}
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
}



/// A stub class for ModalDissolvers.
/// This class is useful for ignoring calls of `UIViewController#dismiss` for testing.
///
/// The completion of `dismiss(animated:Bool, completion:(() -> Void)?)` will be called asynchronously.
public final class ModalDissolverAsyncStub: ModalDissolverProtocol {
    public init() {}


    public func dismiss(animated: Bool) {}
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            completion?()
        }
    }
}



/// A stub class for ModalDissolvers.
/// This class is useful for ignoring calls of `UIViewController#dismiss` for testing.
///
/// The completion of `dismiss(animated:Bool, completion:(() -> Void)?)` will be never called.
public final class ModalDissolverNeverStub: ModalDissolverProtocol {
    public init() {}


    public func dismiss(animated: Bool) {}
    public func dismiss(animated: Bool, completion: (() -> Void)?) {}
}
