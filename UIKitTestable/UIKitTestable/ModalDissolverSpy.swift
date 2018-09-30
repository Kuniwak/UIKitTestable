import UIKit



/**
 A spy class for ModalDissolver.
 This class is useful for capturing calls of `UIViewController#dismiss` for testing.
 */
public class ModalDissolverSpy: ModalDissolverProtocol {
    public typealias CallArgs = (animated: Bool, completion: (() -> Void)?)


    /**
     Call arguments list for the method `dismiss`.
     You can use the property to test how the method is called.
     */
    public fileprivate(set) var callArgs: [CallArgs] = []


    public var delegate: ModalDissolverProtocol


    public init(delegating delegate: ModalDissolverProtocol = ModalDissolverStub()) {
        self.delegate = delegate
    }


    public func dismiss(animated: Bool) {
        let callArgs: CallArgs = (animated: animated, completion: nil)
        self.callArgs.append(callArgs)

        self.delegate.dismiss(animated: animated)
    }


    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        let callArgs = (animated: animated, completion: completion)
        self.callArgs.append(callArgs)

        self.delegate.dismiss(animated: animated, completion: completion)
    }
}
