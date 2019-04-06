import UIKit



/// A spy class for `GlobalModalDissolver`.
/// This class captures calls of methods of the class for testing.
public final class GlobalModalDissolverSpy: GlobalModalDissolverProtocol {
    /// Call arguments of methods of the class.
    public enum CallArgs: Equatable {
        case dismiss(animated: Bool)
    }


    /// Captured call arguments list for methods of `GlobalModalDissolver`.
    /// You can use the property to verify how the method is called.
    public private(set) var callArgs = [CallArgs]()


    /// A dynamic base class that can control how the last completion is called.
    public var inherited: GlobalModalDissolverProtocol


    /// - parameters:
    ///     - inherited: A base class that can control when the last completion is called.
    public init(inheriting inherited: GlobalModalDissolverProtocol = GlobalModalDissolverNeverStub()) {
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
