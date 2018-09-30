import UIKit
import UIKitTestable



/**
 A spy class for ReverseNavigators.
 This class is useful for ignoring calls of `UINavigationController#popToViewController` for testing.
 */
public class ReverseNavigatorStub: ReverseNavigatorProtocol {
    public var error: ReverseNavigatorError?


    public init(willThrow error: ReverseNavigatorError?) {
        self.error = error
    }


    public func back(animated: Bool) throws {
        guard let error = error else { return }

        throw error
    }
}
