import UIKit



/**
 A stub class for ModalPresenters.
 This class is useful for ignoring calls of `UIViewController#present` for testing.

 The completion of `present(viewController: UIViewController, animated:Bool, completion: (() -> Void)?` will be called when
 `complete()` was called.
 */
public final class ModalPresenterManualStub: ModalPresenterProtocol {
    private var completion: (() -> Void)?


    public init() {}


    public func present(viewController: UIViewController, animated: Bool) {}
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.completion = completion
    }


    public func complete() {
        self.completion?()
    }
}



/**
 A stub class for ModalPresenters.
 This class is useful for ignoring calls of `UIViewController#present` for testing.

 The completion of `present(viewController: UIViewController, animated:Bool, completion: (() -> Void)?` will be called
 synchronously.
 */
public final class ModalPresenterSyncStub: ModalPresenterProtocol {
    public init() {}


    public func present(viewController: UIViewController, animated: Bool) {}
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
}



/**
 A stub class for ModalPresenters.
 This class is useful for ignoring calls of `UIViewController#present` for testing.

 The completion of `present(viewController: UIViewController, animated:Bool, completion: (() -> Void)?` will be called
 synchronously.
 */
public final class ModalPresenterAsyncStub: ModalPresenterProtocol {
    public init() {}


    public func present(viewController: UIViewController, animated: Bool) {}
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            completion?()
        }
    }
}



/**
 A stub class for ModalPresenters.
 This class is useful for ignoring calls of `UIViewController#present` for testing.

 The completion of `present(viewController: UIViewController, animated:Bool, completion: (() -> Void)?` will be never called.
*/
public final class ModalPresenterNeverStub: ModalPresenterProtocol {
    public init() {}


    public func present(viewController: UIViewController, animated: Bool) {}
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {}
}
