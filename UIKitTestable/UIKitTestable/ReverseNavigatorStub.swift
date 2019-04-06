import UIKit



/// A stub class for `ReverseNavigator`.
/// This class is useful to prevent side-effects for testing.
public final class ReverseNavigatorStub: ReverseNavigatorProtocol {
    /// An error will be thrown if not nil.
    public var error: ReverseNavigatorError?


    /// - parameters:
    ///     - error: An error will be thrown if not nil.
    public init(willThrow error: ReverseNavigatorError? = nil) {
        self.error = error
    }


    /// Throws an error if not nil. Otherwise, does nothing.
    public func pop(animated: Bool) throws {
        guard let error = error else { return }

        throw error
    }
}
