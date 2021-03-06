import UIKit



/// A stub class for `WindowsReader`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// - SeeAlso: `WindowsReaderUsages`
public final class WindowsReaderStub: WindowsReaderProtocol {
    /// UIWindows will be returned.
    public var nextResult: [WeakOrUnownedOrStrong<UIWindow>]


    /// UIWindows. You can change the return value by `nextValue`.
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


    /// Returns a newly initialized stub.`
    /// - Parameters:
    ///     - initialResult: UIWindows will be returned.
    public init(willReturn initialResult: [WeakOrUnownedOrStrong<UIWindow>] = []) {
        self.nextResult = initialResult
    }
}
