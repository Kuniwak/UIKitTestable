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



/**
 A wrapper class to encapsulate a implementation of assigning `UIWindow.rootViewController`.
 You can replace the class to the stub or spy for testing.
 */
public final class WindowRootViewControllerWriter: RootViewControllerWriterProtocol {
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
