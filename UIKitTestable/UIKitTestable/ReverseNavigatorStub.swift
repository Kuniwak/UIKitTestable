import UIKit



/// A stub class for `ReverseNavigator`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// - SeeAlso: [`ReverseNavigatorUsages`](https://kuniwak.github.io/UIKitTestable/UIKitTestableAppTests/Classes/ReverseNavigatorUsages.html).
public final class ReverseNavigatorStub: ReverseNavigatorProtocol {
    /// An error will be thrown if not nil.
    public var error: NoSuchDestinationViewControllerInNavigationStack?


    /// Returns a newly initialized stub.`
    /// - Parameters:
    ///     - error: An error will be thrown if not nil.
    public init(willThrow error: NoSuchDestinationViewControllerInNavigationStack? = nil) {
        self.error = error
    }


    /// Throws an error if not nil. Otherwise, does nothing.
    public func pop(animated: Bool) throws {
        guard let error = error else { return }

        throw error
    }
}
