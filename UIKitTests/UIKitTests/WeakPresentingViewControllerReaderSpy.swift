import UIKit
import UIKitTestable



public final class WeakPresentingViewControllerReaderSpy: WeakPresentingViewControllerReaderProtocol {
    public enum CallArgs: Equatable {
        case presentingViewController
    }


    public private(set) var callArgs = [CallArgs]()
    public var delegate: WeakPresentingViewControllerReaderProtocol


    public init(delegating delegate: WeakPresentingViewControllerReaderProtocol) {
        self.delegate = delegate
    }


    public var presentingViewController: UIViewController? {
        self.callArgs.append(.presentingViewController)
        return self.delegate.presentingViewController
    }
}
