import UIKit



public final class RootViewControllerReaderStub: RootViewControllerReaderProtocol {
    public var nextResult: WeakOrUnownedOrStrong<UIViewController>


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


    public init(willReturn initialResult: WeakOrUnownedOrStrong<UIViewController> = .empty()) {
        self.nextResult = initialResult
    }
}
