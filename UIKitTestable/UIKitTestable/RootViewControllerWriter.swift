import UIKit



/**
 A type for wrapper class of `UIWindow.rootViewController`.
 */
public protocol RootViewControllerWriterProtocol: AnyObject {
    /**
     Replace the root UIViewController of UIWindow to the specified one.
     */
    func alter(to rootViewController: UIViewController)


    /**
     Replace the root UIViewController of UIWindow to the specified one.
     */
    func alter(to rootViewController: UIViewController, completion: (() -> Void)?)
}



extension RootViewControllerWriterProtocol {
    public static func manualStub() -> RootViewControllerWriterManualStub {
        return RootViewControllerWriterManualStub()
    }


    public static func syncStub() -> RootViewControllerWriterSyncStub {
        return RootViewControllerWriterSyncStub()
    }


    public static func asyncStub() -> RootViewControllerWriterAsyncStub {
        return RootViewControllerWriterAsyncStub()
    }


    public static func neverStub() -> RootViewControllerWriterNeverStub {
        return RootViewControllerWriterNeverStub()
    }


    public static func spy(
        inheriting inherited: RootViewControllerWriterProtocol = RootViewControllerWriterNeverStub()
    ) -> RootViewControllerWriterSpy {
        return RootViewControllerWriterSpy(inheriting: inherited)
    }
}



/**
 A wrapper class to encapsulate a implementation of assigning `UIWindow.rootViewController`.
 You can replace the class to the stub or spy for testing.
 */
public final class WindowRootViewControllerWriter: RootViewControllerWriterProtocol {
    // NOTE: References to UIWindow must be weak or unowned. Because UIWindow have a UIViewController as their
    //       rootViewController, so memory are leaked if the UIViewController has a instance of the class.
    private let window: WeakOrUnowned<UIWindow>


    /**
     Return newly initialized RootViewControllerHolder for the specified UIWindow.
     You can replace the root UIViewController of the window by calling `#alter`
     */
    public init(whoHaveViewController window: WeakOrUnowned<UIWindow>) {
        self.window = window
    }


    public func alter(to rootViewController: UIViewController) {
        self.alter(to: rootViewController, completion: nil)
    }


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
