import UIKit
import UIKitTestable



public class RootViewControllerReaderSpy: RootViewControllerReaderProtocol {
    public enum CallArgs: Equatable {
        case rootViewController
    }


    public private(set) var callArgs = [CallArgs]()
    private var delegate: RootViewControllerReaderProtocol


    public var rootViewController: UIViewController? {
        self.callArgs.append(.rootViewController)

        return self.delegate.rootViewController
    }


    public init(delegating delegate: RootViewControllerReaderProtocol) {
        self.delegate = delegate
    }
}