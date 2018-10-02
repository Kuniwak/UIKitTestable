import UIKit
import UIKitTestable


public final class GlobalModalDissolverSpy: GlobalModalDissolverProtocol {
    public enum CallArgs: Equatable {
        case dismiss(animated: Bool)
    }


    public private(set) var callArgs = [CallArgs]()
    public var delegate: GlobalModalDissolverProtocol


    public init(delegated delegate: GlobalModalDissolverProtocol) {
        self.delegate = delegate
    }


    public func dismiss(animated: Bool) {
        self.delegate.dismiss(animated: animated)
    }


    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.callArgs.append(.dismiss(animated: animated))

        self.delegate.dismiss(animated: animated, completion: completion)
    }
}