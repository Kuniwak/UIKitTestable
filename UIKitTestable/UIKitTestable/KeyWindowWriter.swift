import UIKit



public protocol KeyWindowWriterProtocol {
    func makeKey()
    func becomeKey()
    func resignKey()
}



public class KeyWindowWriter: KeyWindowWriterProtocol {
    private let window: UIWindow


    public init(modifying window: UIWindow) {
        self.window = window
    }


    public func makeKey() {
        self.window.makeKey()
    }


    public func becomeKey() {
        self.becomeKey()
    }


    public func resignKey() {
        self.resignKey()
    }
}



public class NullKeyWindowWriter: KeyWindowWriterProtocol {
    public func makeKey() {}
    public func becomeKey() {}
    public func resignKey() {}
}