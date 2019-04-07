import UIKit



/// A protocol for wrapper classes that encapsulate some methods of `UIWindow`.
/// You can use some stubs or spies instead of actual classes for testing.
/// - SeeAlso: `KeyWindowMakerUsages`.
public protocol KeyWindowMakerProtocol {
    /// Shows the window and makes it the key window.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiwindow/1621610-makekey)
    func makeKey()

    /// Makes the receiver the key window.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiwindow/1621601-makekeyandvisible)
    func makeKeyAndVisible()
}



/// Returns a stub that do nothing.
public func stub() -> KeyWindowMakerStub {
    return KeyWindowMakerStub()
}



/// A wrapper classes that encapsulate some methods of `UIWindow`.
/// You can replace the class with the stub or spy for testing.
/// - SeeAlso: `KeyWindowMakerUsages`.
public final class KeyWindowMaker: KeyWindowMakerProtocol {
    private let window: WeakOrUnowned<UIWindow>


    /// Returns a newly initialized `KeyWindowMaker` with the UIWindow.
    /// - Parameters:
    ///     - window: UIWindow that managed wrapped by a weak or unowned reference.
    public init(modifying window: WeakOrUnowned<UIWindow>) {
        self.window = window
    }


    /// Shows the window and makes it the key window.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiwindow/1621610-makekey)
    public func makeKey() {
        switch self.window {
        case .weakReference(let weak):
            weak.do { window in
                window?.makeKey()
            }
        case .unownedReference(let unowned):
            unowned.do { window in
                window.makeKey()
            }
        }
    }


    /// Makes the receiver the key window.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiwindow/1621601-makekeyandvisible)
    public func makeKeyAndVisible() {
        switch self.window {
        case .weakReference(let weak):
            weak.do { window in
                window?.makeKeyAndVisible()
            }
        case .unownedReference(let unowned):
            unowned.do { window in
                window.makeKeyAndVisible()
            }
        }
    }
}
