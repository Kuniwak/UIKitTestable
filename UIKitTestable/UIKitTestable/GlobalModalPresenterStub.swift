import UIKit



/**
 A stub class for GlobalModalPresenter.
 This class is useful for ignoring calls of `GlobalModalPresenter#present` for testing.

 The completion of `present(viewController:UIViewController, animated:Bool, completion:(() -> Void)?)` can be called when
 `complete()` is called.
 */
public final class GlobalModalPresenterStub: GlobalModalPresenterProtocol {
    private var completion: (() -> Void)?


    public init() {}


    public func present(viewController: UIViewController, animated: Bool) {}
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.completion = completion
    }


    public func complete() {
        completion?()
    }
}



/**
 A stub class for GlobalModalPresenter.
 This class is useful for ignoring calls of `GlobalModalPresenter#present` for testing.

 The completion of `present(viewController:UIViewController, animated:Bool, completion:(() -> Void)?)` will be called
 synchronously.
 */
public final class GlobalModalPresenterSyncStub: GlobalModalPresenterProtocol {
    public init() {}


    public func present(viewController: UIViewController, animated: Bool) {}
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
}



/**
 A stub class for GlobalModalPresenter.
 This class is useful for ignoring calls of `GlobalModalPresenter#present` for testing.

 The completion of `present(viewController:UIViewController, animated:Bool, completion:(() -> Void)?)` will be called
 asynchronously.
 */
public final class GlobalModalPresenterAsyncStub: GlobalModalPresenterProtocol {
    public init() {}


    public func present(viewController: UIViewController, animated: Bool) {}
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            completion?()
        }
    }
}



/**
 A stub class for GlobalModalPresenter.
 This class is useful for ignoring calls of `GlobalModalPresenter#present` for testing.

 The completion of `present(viewController:UIViewController, animated:Bool, completion:(() -> Void)?)` will be never called.
 */
public final class GlobalModalPresenterNeverStub: GlobalModalPresenterProtocol {
    public init() {}


    public func present(viewController: UIViewController, animated: Bool) {}
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {}
}
