import UIKit
import UIKitTestable



public class RootViewControllerReadWriterStub: RootViewControllerReaderStub, RootViewControllerReadWriterProtocol {
    private var completion: (() -> Void)?


    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        self.completion = completion
    }


    public func complete() {
        self.completion?()
    }
}



public class RootViewControllerReadWriterSyncStub: RootViewControllerReaderStub, RootViewControllerReadWriterProtocol {
    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        completion?()
    }
}



public class RootViewControllerReadWriterAsyncStub: RootViewControllerReaderStub, RootViewControllerReadWriterProtocol {
    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            completion?()
        }
    }
}



public class RootViewControllerReadWriterNeverStub: RootViewControllerReaderStub, RootViewControllerReadWriterProtocol {
    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {}
}
