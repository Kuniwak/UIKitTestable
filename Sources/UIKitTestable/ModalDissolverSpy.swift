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


    public var inherited: ModalDissolverProtocol


    public init() {
        self.inherited = ModalDissolverStub()
    }


    public init(inheriting inherited: ModalDissolverProtocol) {
        self.inherited = inherited
    }


    public func dismiss(animated: Bool) {
        self.inherited.dismiss(animated: animated)

        let callArgs: CallArgs = (animated: animated, completion: nil)
        self.callArgs.append(callArgs)
    }


    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.inherited.dismiss(animated: animated, completion: completion)

        let callArgs = (animated: animated, completion: completion)
        self.callArgs.append(callArgs)
    }
}
