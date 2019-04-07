import UIKit



/// A protocol for wrapper classes that encapsulate `UIViewController#present(_: UIViewController, animated: Bool)`.
/// You can use some stubs or spies instead of actual classes.
/// - SeeAlso: `ModalPresenterUsages`.
public protocol ModalPresenterProtocol {
    /// Presents a view controller modally.
    /// This method behave like `UIViewController#present(UIViewController, animated: Bool)`
    func present(viewController: UIViewController, animated: Bool)


    /// Presents a view controller modally.
    /// This method behave like `UIViewController#present(UIViewController, animated: Bool, completion: (() -> Void)?)`
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
}



/// Returns a stub that call the given completion immediately.
public func syncStub() -> ModalPresenterSyncStub {
    return ModalPresenterSyncStub()
}


/// Returns a stub that call the given completion asynchronously.
public func asyncStub() -> ModalPresenterAsyncStub {
    return ModalPresenterAsyncStub()
}


/// Returns a stub that will never call the given completion.
public func neverStub() -> ModalPresenterNeverStub {
    return ModalPresenterNeverStub()
}



/// A wrapper class to encapsulate a implementation of `UIViewController#present(_: UIViewController, animated: Bool)`.
/// You can replace the class with the stub or spy for testing.
public final class ModalPresenter<ViewController: UIViewController>: ModalPresenterProtocol {
    private let groundViewController: WeakOrUnowned<ViewController>


    /// Returns newly initialized ModalPresenter with the UIViewController.
    /// Some UIViewControllers will be present on the specified UIViewController of the function.
    public init(wherePresentOn groundViewController: WeakOrUnowned<ViewController>) {
        self.groundViewController = groundViewController
    }


    /// Presents a view controller modally.
    /// This method behave like `UIViewController#present(UIViewController, animated: Bool)`
    public func present(viewController: UIViewController, animated: Bool) {
        switch self.groundViewController {
        case .weakReference(let weak):
            weak.do { groundViewController in
                groundViewController?.present(viewController, animated: animated)
            }
        case .unownedReference(let unowned):
            unowned.do { groundViewController in
                groundViewController.present(viewController, animated: animated)
            }
        }
    }


    /// Presents a view controller modally.
    /// This method behave like `UIViewController#present(UIViewController, animated: Bool, completion: (() -> Void)?)`
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        switch self.groundViewController {
        case .weakReference(let weak):
            weak.do { groundViewController in
                groundViewController?.present(viewController, animated: animated, completion: completion)
            }
        case .unownedReference(let unowned):
            unowned.do { groundViewController in
                groundViewController.present(viewController, animated: animated, completion: completion)
            }
        }
    }
}
