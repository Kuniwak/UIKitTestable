import UIKit



/// A spy class for dismissing global modals.
public final class GlobalModalDissolverSpy: GlobalModalDissolverProtocol {
    public enum CallArgs: Equatable {
        case dismiss(animated: Bool)
    }


    public private(set) var callArgs = [CallArgs]()
    public var inherited: GlobalModalDissolverProtocol


    public init(inheriting inherited: GlobalModalDissolverProtocol) {
        self.inherited = inherited
    }


    public func dismiss(animated: Bool) {
        self.inherited.dismiss(animated: animated)
    }


    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.callArgs.append(.dismiss(animated: animated))

        self.inherited.dismiss(animated: animated, completion: completion)
    }
}
