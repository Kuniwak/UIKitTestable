import UIKit



public protocol RootViewControllerReaderProtocol: AnyObject {
    var rootViewController: UIViewController? { get }
}



public class RootViewControllerReader: RootViewControllerReaderProtocol {
    private let window: UIWindow


    public var rootViewController: UIViewController? {
        return self.window.rootViewController
    }


    public init(whoHaveRootViewController window: UIWindow) {
        self.window = window
    }
}