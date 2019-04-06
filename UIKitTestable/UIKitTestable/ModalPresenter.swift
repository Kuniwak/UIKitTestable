import UIKit



/// A type for encapsulating classes of `UIViewController#present(_: UIViewController, animated: Bool)`.
public protocol ModalPresenterProtocol {
    /// Presents a view controller modally.
    /// This method behave like `UIViewController#present(UIViewController, animated: Bool)`
    func present(viewController: UIViewController, animated: Bool)


    /// Presents a view controller modally.
    /// This method behave like `UIViewController#present(UIViewController, animated: Bool, completion: (() -> Void)?)`
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
}



extension ModalPresenterProtocol {
    /// Returns a stub that can call a last completion manually.
    public static func manualStub() -> ModalPresenterManualStub {
        return ModalPresenterManualStub()
    }


    /// Returns a stub that call the given completion immediately.
    public static func syncStub() -> ModalPresenterSyncStub {
        return ModalPresenterSyncStub()
    }


    /// Returns a stub that call the given completion asynchronously.
    public static func asyncStub() -> ModalPresenterAsyncStub {
        return ModalPresenterAsyncStub()
    }


    /// Returns a stub that will never call the given completion.
    public static func neverStub() -> ModalPresenterNeverStub {
        return ModalPresenterNeverStub()
    }


    /// Returns a spy that record how methods were called.
    /// - parameters:
    ///     - inherited: A dynamic base class control how call a completion.
    public static func spy(
        inheriting inherited: ModalPresenterProtocol = ModalPresenterNeverStub()
    ) -> ModalPresenterSpy {
        return ModalPresenterSpy(inheriting: inherited)
    }
}



/// A wrapper class to encapsulate a implementation of `UIViewController#present(_: UIViewController, animated: Bool)`.
public final class ModalPresenter<ViewController: UIViewController>: ModalPresenterProtocol {
    private let groundViewController: WeakOrUnowned<ViewController>


    /// Returns newly initialized ModalPresenter with the UIViewController.
    /// Some UIViewControllers will be present on the specified UIViewController of the function.
    public init(wherePresentOn groundViewController: WeakOrUnowned<ViewController>) {
        self.groundViewController = groundViewController
    }


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
