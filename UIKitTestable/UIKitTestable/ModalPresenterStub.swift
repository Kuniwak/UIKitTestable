import UIKit



/**
 A stub class for ModalPresenters.
 This class is useful for ignoring calls of `UIViewController#present` for testing.
 */
public class ModalPresenterStub: ModalPresenterProtocol {
    public init() {}


    public func present(viewController: UIViewController, animated: Bool) {}
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
}