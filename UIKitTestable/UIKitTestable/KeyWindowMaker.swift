import UIKit



public protocol KeyWindowMakerProtocol {
    func makeKey()
    func makeKeyAndVisible()
    func becomeKey()
    func resignKey()
}



public final class KeyWindowMaker: KeyWindowMakerProtocol {
    private let window: UIWindow


    public init(modifying window: UIWindow) {
        self.window = window
    }


    public func makeKey() {
        self.window.makeKey()
    }


    public func makeKeyAndVisible() {
        self.window.makeKeyAndVisible()
    }


    public func becomeKey() {
        self.window.becomeKey()
    }


    public func resignKey() {
        self.window.resignKey()
    }
}



public final class NullKeyWindowWriter: KeyWindowMakerProtocol {
    public func makeKey() {}
    public func makeKeyAndVisible() {}
    public func becomeKey() {}
    public func resignKey() {}
}