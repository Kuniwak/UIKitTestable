import UIKit
import UIKitTestable



public final class UnownedPresentingViewControllerReaderSpy: UnownedPresentingViewControllerReaderProtocol {
    public enum CallArgs: Equatable {
        case presentingViewController
    }


    public private(set) var callArgs = [CallArgs]()
    public var delegate: UnownedPresentingViewControllerReaderProtocol


    public init(delegating delegate: UnownedPresentingViewControllerReaderProtocol) {
        self.delegate = delegate
    }


    public var presentingViewController: UIViewController {
        self.callArgs.append(.presentingViewController)
        return self.delegate.presentingViewController
    }
}
