import UIKit



/**
 A type for encapsulating classes of `UIViewController#present(_: UIViewController, animated: Bool)`.
 */
public protocol ModalPresenterProtocol {
    /**
     Presents a view controller like a modal.
     This method behave like `UIViewController#present(UIViewController, animated: Bool)`
     */
    func present(viewController: UIViewController, animated: Bool)


    /**
     Presents a view controller like a modal.
     This method behave like `UIViewController#present(UIViewController, animated: Bool, completion: (() -> Void)?)`
     */
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
}



extension ModalPresenterProtocol {
    public static func stub() -> ModalPresenterStub {
        return ModalPresenterStub()
    }


    public static func syncStub() -> ModalPresenterSyncStub {
        return ModalPresenterSyncStub()
    }


    public static func asyncStub() -> ModalPresenterAsyncStub {
        return ModalPresenterAsyncStub()
    }


    public static func never() -> ModalPresenterNeverStub {
        return ModalPresenterNeverStub()
    }


    public static func spy(
        inheriting inherited: ModalPresenterProtocol = ModalPresenterSyncStub()
    ) -> ModalPresenterSpy {
        return ModalPresenterSpy(inheriting: inherited)
    }
}



/**
 A wrapper class to encapsulate a implementation of `UIViewController#present(_: UIViewController, animated: Bool)`.
 */
public final class ModalPresenter: ModalPresenterProtocol {
    private let groundViewController: WeakOrUnowned<UIViewController>


    /**
     Return newly initialized ModalPresenter with the UIViewController.
     Some UIViewControllers will be present on the specified UIViewController of the function.
     */
    public init(wherePresentOn groundViewController: WeakOrUnowned<UIViewController>) {
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
