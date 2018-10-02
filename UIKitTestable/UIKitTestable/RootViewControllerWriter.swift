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
    private let window: UIWindow


    /**
     Return newly initialized RootViewControllerHolder for the specified UIWindow.
     You can replace the root UIViewController of the window by calling `#alter`
     */
    public init(whoHaveViewController window: UIWindow) {
        self.window = window
    }


    public func alter(to rootViewController: UIViewController) {
        self.alter(to: rootViewController, completion: nil)
    }


    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        guard let oldViewController = self.window.rootViewController else {
            self.window.rootViewController = rootViewController
            completion?()
            return
        }

        oldViewController.dismiss(animated: false, completion: {
            self.window.rootViewController = rootViewController
            completion?()
        })
    }
}
