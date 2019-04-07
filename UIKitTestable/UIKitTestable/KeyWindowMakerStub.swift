import UIKit



/// A classes that encapsulate some methods of `UIWindow`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// - SeeAlso: `KeyWindowMakerUsages`.
public final class KeyWindowMakerStub: KeyWindowMakerProtocol {
    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func makeKey() {}


    /// Does nothing.
    public func makeKeyAndVisible() {}
}
