import UIKit



public protocol RootViewControllerReaderProtocol: AnyObject {
    var rootViewController: UIViewController? { get }
}



public final class WindowRootViewControllerReader: RootViewControllerReaderProtocol {
    private let window: WeakOrUnowned<UIWindow>


    public var rootViewController: UIViewController? {
        return self.window.value?.rootViewController
    }


    public init(whoHaveRootViewController window: WeakOrUnowned<UIWindow>) {
        self.window = window
    }
}