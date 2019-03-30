import UIKit



public final class RootViewControllerReaderStub: RootViewControllerReaderProtocol {
    // NOTE: This reference can make memory leaks but it should not be a weak reference.
    //       Because tests can be failed caused by unexpected releasing.
    public var rootViewController: UIViewController?


    public init(alwaysReturn rootViewController: UIViewController?) {
        self.rootViewController = rootViewController
    }
}
