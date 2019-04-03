import UIKit



/**
 A spy class for ReverseNavigators.
 This class is useful for capturing calls of `UINavigationController#popToViewController` for testing.
 */
public final class ReverseNavigatorSpy: ReverseNavigatorProtocol {
    public enum CallArgs: Equatable {
        case back(animated: Bool)
    }


    /**
     Call arguments list for the method `#back(animated: Bool)`.
     You can use the property to test how the method is called.
     */
    public private(set) var callArgs: [CallArgs] = []


    public var inherited: ReverseNavigatorProtocol


    public init(inheriting inherited: ReverseNavigatorProtocol = ReverseNavigatorStub(willThrow: nil)) {
        self.inherited = inherited
    }


    public func pop(animated: Bool) throws {
        self.callArgs.append(.back(animated: animated))

        try self.inherited.pop(animated: animated)
    }
}
