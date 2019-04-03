import UIKit



/**
 A type for wrapper classes of `UIViewController#dismiss(animated: Bool)`.
 */
public protocol ModalDissolverProtocol {
    /**
     Dismisses the view controller that was presented as a modal by the view controller.
     This method behave like `UIViewController#dismiss(animated: Bool)`
     */
    func dismiss(animated: Bool)


    /**
     Dismisses the view controller that was presented as a modal by the view controller.
     This method behave like `UIViewController#dismiss(animated: Bool, completion: (() -> Void)?)`
     */
    func dismiss(animated: Bool, completion: (() -> Void)?)
}



extension ModalDissolverProtocol {
    public static func stub() -> ModalDissolverStub {
        return ModalDissolverStub()
    }


    public static func syncStub() -> ModalDissolverSyncStub {
        return ModalDissolverSyncStub()
    }


    public static func asyncStub() -> ModalDissolverAsyncStub {
        return ModalDissolverAsyncStub()
    }


    public static func never() -> ModalDissolverNeverStub {
        return ModalDissolverNeverStub()
    }


    public static func spy(
        inheriting inherited: ModalDissolverProtocol = ModalDissolverSyncStub()
    ) -> ModalDissolverSpy {
        return ModalDissolverSpy(inheriting: inherited)
    }
}



/**
 A wrapper class to encapsulate a implementation of `UIViewController#disiss(animated: Bool)`.
 You can replace the class to the stub or spy for testing.
 */
public final class ModalDissolver: ModalDissolverProtocol {
    private let viewController: WeakOrUnowned<UIViewController>


    /**
     Return newly initialized ModalDissolver of the UIViewController.
     The specified UIViewController will be dismissed by calling the method `dismiss(animated: Bool)`.
     */
    public init(willDismiss viewController: WeakOrUnowned<UIViewController>) {
        self.viewController = viewController
    }


    public func dismiss(animated: Bool) {
        switch self.viewController {
        case .weakReference(let weak):
            weak.do { viewController in
                viewController?.dismiss(animated: animated)
            }
        case .unownedReference(let unowned):
            unowned.do { viewController in
                viewController.dismiss(animated: animated)
            }
        }
    }


    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        switch self.viewController {
        case .weakReference(let weak):
            weak.do { viewController in
                viewController?.dismiss(animated: animated, completion: completion)
            }
        case .unownedReference(let unowned):
            unowned.do { viewController in
                viewController.dismiss(animated: animated, completion: completion)
            }
        }
    }
}
