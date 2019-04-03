import UIKit



public final class WindowsReaderStub: WindowsReaderProtocol {
    public var nextResult: [WeakOrUnownedOrStrong<UIWindow>]


    public var windows: [UIWindow] {
        return self.nextResult.compactMap { (weakOrUnownedOrStrong) -> UIWindow? in
            switch weakOrUnownedOrStrong {
            case .weakReference(let weak):
                return weak.value
            case .unownedReference(let unowned):
                return unowned.value
            case .strongReference(let strong):
                return strong.value
            }
        }
    }


    public init(willReturn initialResult: [WeakOrUnownedOrStrong<UIWindow>] = []) {
        self.nextResult = initialResult
    }
}
