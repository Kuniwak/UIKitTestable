import UIKit



/// A protocol for wrapper classes that encapsulate `UIViewController#dismiss(animated: Bool)`.
/// You can use some stubs or spies instead of actual classes for testing.
/// - SeeAlso: [`ModalDismisserUsages`](https://kuniwak.github.io/UIKitTestable/UIKitTestableAppTests/Classes/ModalDismisserUsages.html).
public protocol ModalDismisserProtocol {
    /// Dismisses the presented view controller.
    /// This method behave like `UIViewController#dismiss(animated: Bool)`
    func dismiss(animated: Bool)


    /// Dismisses the presented view controller.
    /// This method behave like `UIViewController#dismiss(animated: Bool, completion: (() -> Void)?)`
    func dismiss(animated: Bool, completion: (() -> Void)?)
}


/// Returns a stub that call the given completion immediately.
public func syncStub() -> ModalDismisserSyncStub {
    return ModalDismisserSyncStub()
}


/// Returns a stub that call the given completion asynchronously.
public func asyncStub() -> ModalDismisserAsyncStub {
    return ModalDismisserAsyncStub()
}


/// Returns a stub that will never call the given completion.
public func neverStub() -> ModalDismisserNeverStub {
    return ModalDismisserNeverStub()
}



/// A wrapper class to encapsulate a implementation of `UIViewController#disiss(animated: Bool)`.
/// You can replace the class with the stub or spy for testing.
/// - SeeAlso: [`ModalDismisserUsages`](https://kuniwak.github.io/UIKitTestable/UIKitTestableAppTests/Classes/ModalDismisserUsages.html).
public final class ModalDismisser: ModalDismisserProtocol {
    private let viewController: WeakOrUnowned<UIViewController>


    /// - Parameters:
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
