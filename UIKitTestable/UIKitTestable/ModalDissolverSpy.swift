import UIKit



/**
 A spy class for ModalDissolver.
 This class is useful for capturing calls of `UIViewController#dismiss` for testing.
 */
public final class ModalDissolverSpy: ModalDissolverProtocol {
    public enum CallArgs: Equatable {
        case dismiss(animated: Bool)
    }


    /**
     Call arguments list for the method `dismiss`.
     You can use the property to test how the method is called.
     */
    public private(set) var callArgs: [CallArgs] = []


    public var inherited: ModalDissolverProtocol


    public init(inheriting inherited: ModalDissolverProtocol = ModalDissolverStub()) {
        self.inherited = inherited
    }


    public func dismiss(animated: Bool) {
        self.callArgs.append(.dismiss(animated: animated))

        self.inherited.dismiss(animated: animated)
    }


    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.callArgs.append(.dismiss(animated: animated))

        self.inherited.dismiss(animated: animated, completion: completion)
    }
}
