import UIKit



/// A spy class for `ModalDissolver`.
/// This class captures calls of methods of the class for testing.
public final class ModalDissolverSpy: ModalDissolverProtocol {
    /// Call arguments of methods of the class.
    public enum CallArgs: Equatable {
        case dismiss(animated: Bool)
    }


    /// Captured call arguments list for methods.
    /// You can use the property to verify how methods were called.
    public private(set) var callArgs: [CallArgs] = []


    /// A dynamic base class that can control how the last completion is called.
    public var inherited: ModalDissolverProtocol


    public init(inheriting inherited: ModalDissolverProtocol = ModalDissolverNeverStub()) {
        self.inherited = inherited
    }


    /// Records the call arguments and calls the dynamic base class.
    public func dismiss(animated: Bool) {
        self.callArgs.append(.dismiss(animated: animated))

        self.inherited.dismiss(animated: animated)
    }


    /// Records the call arguments and calls the dynamic base class.
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.callArgs.append(.dismiss(animated: animated))

        self.inherited.dismiss(animated: animated, completion: completion)
    }
}
