import UIKit



/**
 A spy class for ReverseNavigators.
 This class is useful for capturing calls of `UINavigationController#popToViewController` for testing.
 */
public class ReverseNavigatorSpy: ReverseNavigatorProtocol {
    public enum CallArgs: Equatable {
        case back(animated: Bool)
    }


    /**
     Call arguments list for the method `#back(animated: Bool)`.
     You can use the property to test how the method is called.
     */
    public private(set) var callArgs: [CallArgs] = []


    public var delegate: ReverseNavigatorProtocol


    public init(delegating delegate: ReverseNavigatorProtocol = ReverseNavigatorStub(willThrow: nil)) {
        self.delegate = delegate
    }


    public func back(animated: Bool) throws {
        self.callArgs.append(.back(animated: animated))

        try self.delegate.back(animated: animated)
    }
}
