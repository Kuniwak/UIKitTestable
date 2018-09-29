import UIKit



/**
 A stub class for GlobalModalPresenter.
 This class is useful for ignoring calls of `GlobalModalPresenter#present` for testing.
 */
public class GlobalModalPresenterStub: GlobalModalPresenterProtocol {
    public var dissolver: ModalDissolverProtocol


    public init(exposing dissolver: ModalDissolverProtocol) {
        self.dissolver = dissolver
    }


    public func present(viewController: UIViewController, animated: Bool) {}
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
}