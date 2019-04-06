import UIKit



/// A type for wrapper classes of `UIViewController#dismiss(animated: Bool)`.
public protocol ModalDissolverProtocol {
    /// Dismisses the presented view controller.
    /// This method behave like `UIViewController#dismiss(animated: Bool)`
    func dismiss(animated: Bool)


    /// Dismisses the presented view controller.
    /// This method behave like `UIViewController#dismiss(animated: Bool, completion: (() -> Void)?)`
    func dismiss(animated: Bool, completion: (() -> Void)?)
}



extension ModalDissolverProtocol {
    /// Returns a stub that can call a last completion manually.
    public static func manualStub() -> ModalDissolverManualStub {
        return ModalDissolverManualStub()
    }


    /// Returns a stub that call the given completion immediately.
    public static func syncStub() -> ModalDissolverSyncStub {
        return ModalDissolverSyncStub()
    }


    /// Returns a stub that call the given completion asynchronously.
    public static func asyncStub() -> ModalDissolverAsyncStub {
        return ModalDissolverAsyncStub()
    }


    /// Returns a stub that will never call the given completion.
    public static func neverStub() -> ModalDissolverNeverStub {
        return ModalDissolverNeverStub()
    }


    /// Returns a spy that record how methods were called.
    /// - parameters:
    ///     - inherited: A dynamic base class control how call a completion.
    public static func spy(
        inheriting inherited: ModalDissolverProtocol = ModalDissolverNeverStub()
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


    /// - parameters:
    ///     - viewController: An UIViewController is dismissed when the methods `dismiss` are called.
    public init(willDismiss viewController: WeakOrUnowned<UIViewController>) {
        self.viewController = viewController
    }


    /// Dismisses the presented view controller.
    /// This method behave like `UIViewController#dismiss(animated: Bool)`
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


    /// Dismisses the presented view controller.
    /// This method behave like `UIViewController#dismiss(animated: Bool, completion: (() -> Void)?)`
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
