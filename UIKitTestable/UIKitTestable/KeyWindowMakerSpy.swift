import UIKit



/// A spy class for `KeyWindowMaker`s.
/// This class captures calls of methods of the class for testing.
/// - SeeAlso: `KeyWindowMakerUsages`.
public final class KeyWindowMakerSpy: KeyWindowMakerProtocol {
    /// Call arguments of methods of `KeyWindowMakerSpy`.
    public enum CallArgs: Equatable {
        case makeKey
        case makeKeyAndVisible
        case becomeKey
        case resignKey
    }


    /// Captured call arguments list for methods.
    /// You can use the property to verify how methods were called.
    public private(set) var callArgs = [CallArgs]()


    /// A dynamic base class that can control how the last completion is called.
    public var inherited: KeyWindowMakerProtocol


    public init(inheriting inherited: KeyWindowMakerProtocol = KeyWindowMakerStub()) {
        self.inherited = inherited
    }


    /// Records the call arguments and calls the dynamic base class.
    public func makeKey() {
        self.callArgs.append(.makeKey)

        self.inherited.makeKey()
    }


    /// Records the call arguments and calls the dynamic base class.
    public func makeKeyAndVisible() {
        self.callArgs.append(.makeKeyAndVisible)

        self.inherited.makeKeyAndVisible()
    }
}
