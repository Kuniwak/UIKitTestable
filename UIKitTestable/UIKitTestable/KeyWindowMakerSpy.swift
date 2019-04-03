import UIKit



public final class KeyWindowMakerSpy: KeyWindowMakerProtocol {
    public enum CallArgs: Equatable {
        case makeKey
        case makeKeyAndVisible
        case becomeKey
        case resignKey
    }
    public private(set) var callArgs = [CallArgs]()
    public var inherited: KeyWindowMakerProtocol


    public init(inheriting inherited: KeyWindowMakerProtocol = KeyWindowMakerStub()) {
        self.inherited = inherited
    }


    public func makeKey() {
        self.callArgs.append(.makeKey)

        self.inherited.makeKey()
    }


    public func makeKeyAndVisible() {
        self.callArgs.append(.makeKeyAndVisible)

        self.inherited.makeKeyAndVisible()
    }


    public func becomeKey() {
        self.callArgs.append(.becomeKey)

        self.inherited.becomeKey()
    }


    public func resignKey() {
        self.callArgs.append(.resignKey)

        self.inherited.resignKey()
    }
}
