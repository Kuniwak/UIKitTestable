import UIKit



/**
 A type for wrapper classes of `UIViewController#dismiss(animated: Bool)`.
 */
public protocol ModalDissolverProtocol {
    /**
     Dismisses the view controller that was presented modally by the view controller.
     This method behave like `UIViewController#dismiss(animated: Bool)`
     */
    func dismiss(animated: Bool)


    /**
     Dismisses the view controller that was presented modally by the view controller.
     This method behave like `UIViewController#dismiss(animated: Bool, completion: (() -> Void)?)`
     */
    func dismiss(animated: Bool, completion: (() -> Void)?)
}



/**
 A wrapper class to encapsulate a implementation of `UIViewController#disiss(animated: Bool)`.
 You can replace the class to the stub or spy for testing.
 */
public class ModalDissolver: ModalDissolverProtocol {
    private let viewController: UIViewController


    /**
     Return newly initialized ModalDissolver of the UIViewController.
     The specified UIViewController will be dismissed by calling the method `dismiss(animated: Bool)`.
     */
    public init(willDismiss viewController: UIViewController) {
        self.viewController = viewController
    }


    public func dismiss(animated: Bool) {
        self.viewController.dismiss(animated: animated)
    }


    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.viewController.dismiss(
            animated: animated,
            completion: completion
        )
    }
}
