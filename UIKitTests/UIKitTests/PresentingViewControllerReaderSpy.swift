import UIKit
import UIKitTestable



public final class PresentingViewControllerReaderSpy: PresentingViewControllerReaderProtocol {
    public enum CallArgs: Equatable {
        case presentingViewController
    }


    public private(set) var callArgs = [CallArgs]()
    public var delegate: PresentingViewControllerReaderProtocol


    public init(delegating delegate: PresentingViewControllerReaderProtocol) {
        self.delegate = delegate
    }


    public var presentingViewController: WeakOrUnowned<UIViewController> {
        self.callArgs.append(.presentingViewController)
        return self.delegate.presentingViewController
    }
}
