import UIKit
import UIKitTestable


/**
 A stub class for ModalDissolvers.
 This class is useful for ignoring calls of `UIViewController#dismiss` for testing.

 The completion of `dismiss(animated:Bool, completion:(() -> Void)?)` will be called when `complete()` is called..
 */
public final class ModalDissolverStub: ModalDissolverProtocol {
    public var completion: (() -> Void)?


    public init() {}


    public func dismiss(animated: Bool) {}
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.completion = completion
    }


    public func complete() {
        self.completion?()
    }
}



/**
 A stub class for ModalDissolvers.
 This class is useful for ignoring calls of `UIViewController#dismiss` for testing.

 The completion of `dismiss(animated:Bool, completion:(() -> Void)?)` will be called synchronously.
 */
public final class ModalDissolverSyncStub: ModalDissolverProtocol {
    public init() {}


    public func dismiss(animated: Bool) {}
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
}




/**
 A stub class for ModalDissolvers.
 This class is useful for ignoring calls of `UIViewController#dismiss` for testing.

 The completion of `dismiss(animated:Bool, completion:(() -> Void)?)` will be called asynchronously.
 */
public final class ModalDissolverAsyncStub: ModalDissolverProtocol {
    public init() {}


    public func dismiss(animated: Bool) {}
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            completion?()
        }
    }
}




/**
 A stub class for ModalDissolvers.
 This class is useful for ignoring calls of `UIViewController#dismiss` for testing.

 The completion of `dismiss(animated:Bool, completion:(() -> Void)?)` will be never called.
 */
public final class ModalDissolverNeverStub: ModalDissolverProtocol {
    public init() {}


    public func dismiss(animated: Bool) {}
    public func dismiss(animated: Bool, completion: (() -> Void)?) {}
}
