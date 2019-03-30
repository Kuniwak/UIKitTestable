import UIKit



public final class KeyWindowMakerSpy: KeyWindowMakerProtocol {
    public enum CallArgs: Equatable {
        case makeKey
        case makeKeyAndVisible
        case becomeKey
        case resignKey
    }
    public private(set) var callArgs = [CallArgs]()
    public var delegate: KeyWindowMakerProtocol


    public init(delegating delegate: KeyWindowMakerProtocol = KeyWindowMakerStub()) {
        self.delegate = delegate
    }


    public func makeKey() {
        self.callArgs.append(.makeKey)

        self.delegate.makeKey()
    }


    public func makeKeyAndVisible() {
        self.callArgs.append(.makeKeyAndVisible)

        self.delegate.makeKeyAndVisible()
    }


    public func becomeKey() {
        self.callArgs.append(.becomeKey)

        self.delegate.becomeKey()
    }


    public func resignKey() {
        self.callArgs.append(.resignKey)

        self.delegate.resignKey()
    }
}
