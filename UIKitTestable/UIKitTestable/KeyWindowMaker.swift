import UIKit



public protocol KeyWindowMakerProtocol {
    func makeKey()
    func makeKeyAndVisible()
    func becomeKey()
    func resignKey()
}



public final class KeyWindowMaker: KeyWindowMakerProtocol {
    private let window: WeakOrUnowned<UIWindow>


    public init(modifying window: WeakOrUnowned<UIWindow>) {
        self.window = window
    }


    public func makeKey() {
        self.window.value?.makeKey()
    }


    public func makeKeyAndVisible() {
        self.window.value?.makeKeyAndVisible()
    }


    public func becomeKey() {
        self.window.value?.becomeKey()
    }


    public func resignKey() {
        self.window.value?.resignKey()
    }
}



public final class NullKeyWindowWriter: KeyWindowMakerProtocol {
    public func makeKey() {}
    public func makeKeyAndVisible() {}
    public func becomeKey() {}
    public func resignKey() {}
}