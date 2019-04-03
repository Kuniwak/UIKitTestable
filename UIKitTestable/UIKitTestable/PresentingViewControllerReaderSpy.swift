import UIKit



public final class PresentingViewControllerReaderSpy: PresentingViewControllerReaderProtocol {
    public enum CallArgs: Equatable {
        case presentingViewController
    }


    public private(set) var callArgs = [CallArgs]()
    public var inherited: PresentingViewControllerReaderProtocol


    public init(inheriting inherited: PresentingViewControllerReaderProtocol) {
        self.inherited = inherited
    }


    public var presentingViewController: WeakOrUnowned<UIViewController> {
        self.callArgs.append(.presentingViewController)
        return self.inherited.presentingViewController
    }
}
