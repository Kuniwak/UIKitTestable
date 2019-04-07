import UIKit


/// A protocol for specialized `ModalDismisser`s presented by `GlobalModalPresenter`s.
/// You can use some stubs or spies instead of actual classes for testing.
/// - SeeAlso: [`GlobalModalDismisserUsages`](https://kuniwak.github.io/UIKitTestable/UIKitTestableAppTests/Classes/GlobalModalDismisserUsages.html).
public protocol GlobalModalDismisserProtocol {
    /// Dismisses the presented view controller.
    /// This method behave like `UIViewController#dismiss(animated: Bool)`
    func dismiss(animated: Bool)


    /// Dismisses the presented view controller.
    /// This method behave like `UIViewController#dismiss(animated: Bool, completion: (() -> Void)?)`
    func dismiss(animated: Bool, completion: (() -> Void)?)
}



/// Returns a stub that call the given completion immediately.
public func syncStub() -> GlobalModalDismisserSyncStub {
    return GlobalModalDismisserSyncStub()
}


/// Returns a stub that call the given completion asynchronously.
public func asyncStub() -> GlobalModalDismisserAsyncStub {
    return GlobalModalDismisserAsyncStub()
}


/// Returns a stub that will never call the given completion.
public func neverStub() -> GlobalModalDismisserNeverStub {
    return GlobalModalDismisserNeverStub()
}
