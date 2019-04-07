import UIKit



/// A protocol for wrapper class that encapsulate a setter for `UIWindow.rootViewController`.
/// You can use some stubs or spies instead of actual classes for testing.
public protocol RootViewControllerWriterProtocol: AnyObject {
    /// Replace the rootViewController to the specified one.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiwindow/1621581-rootviewcontroller#)
    func alter(to rootViewController: UIViewController)


    /// Replace the rootViewController to the specified one.
    /// - Parameters:
    ///     - completion: The block to execute after the view controller is dismissed. This block has no return value and takes no parameters. You may specify nil for this parameter.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiwindow/1621581-rootviewcontroller#)
    func alter(to rootViewController: UIViewController, completion: (() -> Void)?)
}



/// Returns a stub that can call a last completion manually.
public func manualStub() -> RootViewControllerWriterManualStub {
    return RootViewControllerWriterManualStub()
}


/// Returns a stub that call the given completion immediately.
public func syncStub() -> RootViewControllerWriterSyncStub {
    return RootViewControllerWriterSyncStub()
}


/// Returns a stub that call the given completion asynchronously.
public func asyncStub() -> RootViewControllerWriterAsyncStub {
    return RootViewControllerWriterAsyncStub()
}


/// Returns a stub that will never call the given completion.
public func neverStub() -> RootViewControllerWriterNeverStub {
    return RootViewControllerWriterNeverStub()
}



/// A wrapper class that encapsulate a setter for `UIWindow.rootViewController`.
/// You can replace the class to the stub or spy for testing.
public final class WindowRootViewControllerWriter: RootViewControllerWriterProtocol {
    // NOTE: References to UIWindow must be weak or unowned. Because UIWindow have a UIViewController as their
    //       rootViewController, so memory are leaked if the UIViewController has a instance of the class.
    private let window: WeakOrUnowned<UIWindow>


    /// Return newly initialized RootViewControllerHolder for the specified UIWindow.
    /// You can replace the root UIViewController of the window by calling `#alter`
    public init(whoHaveViewController window: WeakOrUnowned<UIWindow>) {
        self.window = window
    }


    /// Replace the rootViewController to the specified one.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiwindow/1621581-rootviewcontroller#)
    public func alter(to rootViewController: UIViewController) {
        self.alter(to: rootViewController, completion: nil)
    }


    /// Replace the rootViewController to the specified one.
    /// - Parameters:
    ///     - completion: The block to execute after the view controller is dismissed. This block has no return value and takes no parameters. You may specify nil for this parameter.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiwindow/1621581-rootviewcontroller#)
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        switch self.window {
        case .weakReference(let weak):
            weak.do { window in
                guard let window = window else { return }
                self.alter(rootViewController: rootViewController, of: window, completion: completion)
            }

        case .unownedReference(let unowned):
            unowned.do { window in
                self.alter(rootViewController: rootViewController, of: window, completion: completion)
            }
        }
    }


    private func alter(rootViewController: UIViewController, of window: UIWindow, completion: (() -> Void)?) {
        guard let oldViewController = window.rootViewController else {
            window.rootViewController = rootViewController
            completion?()
            return
        }

        oldViewController.dismiss(animated: false, completion: {
            window.rootViewController = rootViewController
            completion?()
        })
    }
}
