import UIKit


/// A protocol for specialized ModalPresenters that can present a UIViewController on a top of view hierarchy unconditionally.
/// You can use some stubs or spies instead of actual classes for testing.
/// - SeeAlso: [`GlobalModalPresenterUsages`](https://kuniwak.github.io/UIKitTestable/UIKitTestableAppTests/Classes/GlobalModalPresenterUsages.html).
public protocol GlobalModalPresenterProtocol {
    /// Presents a view controller modally.
    /// This method behave like `UIViewController#present(UIViewController, animated: Bool)`
    func present(viewController: UIViewController, animated: Bool)


    /// Presents a view controller modally.
    /// This method behave like `UIViewController#present(UIViewController, animated: Bool, completion: (() -> Void)?)`
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
}



/// Returns a stub that call the given completion immediately.
public func syncStub() -> GlobalModalPresenterSyncStub {
    return GlobalModalPresenterSyncStub()
}


/// Returns a stub that call the given completion asynchronously.
public func asyncStub() -> GlobalModalPresenterAsyncStub {
    return GlobalModalPresenterAsyncStub()
}


/// Returns a stub that will never call the given completion.
public func neverStub() -> GlobalModalPresenterNeverStub {
    return GlobalModalPresenterNeverStub()
}
