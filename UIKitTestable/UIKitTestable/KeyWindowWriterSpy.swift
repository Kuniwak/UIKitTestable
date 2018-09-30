import UIKit



public class KeyWindowWriterSpy: KeyWindowWriterProtocol {
    public enum CallArgs: Equatable {
        case makeKey
        case becomeKey
        case resignKey
    }
    public private(set) var callArgs = [CallArgs]()
    public var delegate: KeyWindowWriterProtocol


    public init(delegating delegate: KeyWindowWriterProtocol = KeyWindowWriterStub()) {
        self.delegate = delegate
    }


    public func makeKey() {
        self.callArgs.append(.makeKey)

        self.delegate.makeKey()
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