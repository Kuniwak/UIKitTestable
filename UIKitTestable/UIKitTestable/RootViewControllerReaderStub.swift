import UIKit



/// A stub class for `RootViewControllerReader`.
/// This class is useful to prevent side-effects for testing.
public final class RootViewControllerReaderStub: RootViewControllerReaderProtocol {
    /// An UIViewController that will be returned as the rootViewController.
    public var nextResult: WeakOrUnownedOrStrong<UIViewController>


    /// A root ViewController. The returned value can be changed by `nextResult`.
    public var rootViewController: UIViewController? {
        switch self.nextResult {
        case .weakReference(let weak):
            return weak.value
        case .unownedReference(let unowned):
            return unowned.value
        case .strongReference(let strong):
            return strong.value
        }
    }


    /// - parameters:
    ///     - initialResult: An UIViewController that will be returned as rootViewController.
    public init(willReturn initialResult: WeakOrUnownedOrStrong<UIViewController> = .empty()) {
        self.nextResult = initialResult
    }
}
