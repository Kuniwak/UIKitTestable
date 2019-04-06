import UIKit



/// A spy class for `KeyWindowMaker`.
/// This class captures calls of methods of the class for testing.
public final class KeyWindowMakerSpy: KeyWindowMakerProtocol {
    /// Call arguments of methods of the class.
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


    /// Records the call arguments and calls the base class.
    public func becomeKey() {
        self.callArgs.append(.becomeKey)

        self.inherited.becomeKey()
    }


    /// Records the call arguments and calls the base class.
    public func resignKey() {
        self.callArgs.append(.resignKey)

        self.inherited.resignKey()
    }
}
