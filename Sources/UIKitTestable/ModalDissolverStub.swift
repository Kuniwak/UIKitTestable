import UIKit



/**
 A stub class for ModalDissolvers.
 This class is useful for ignoring calls of `UIViewController#dismiss` for testing.
 */
public class ModalDissolverStub: ModalDissolverProtocol {
    public func dismiss(animated: Bool) {}
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
}
