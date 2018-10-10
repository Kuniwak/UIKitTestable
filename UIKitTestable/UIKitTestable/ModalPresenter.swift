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
        self.groundViewController.value?.present(viewController, animated: animated)
    }


    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.groundViewController.value?.present(viewController, animated: animated, completion: completion)
    }
}
