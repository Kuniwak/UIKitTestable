import UIKit



public protocol KeyWindowMakerProtocol {
    func makeKey()
    func makeKeyAndVisible()
    func becomeKey()
    func resignKey()
}



extension KeyWindowMakerProtocol {
    /// Returns a stub that do nothing.
    public static func stub() -> KeyWindowMakerStub {
        return KeyWindowMakerStub()
    }


    /// Returns a spy that record how methods were called.
    /// - parameters:
    ///     - inherited: A dynamic base class control how call a completion.
    public static func spy(
        inheriting inherited: KeyWindowMakerProtocol = KeyWindowMakerStub()
    ) -> KeyWindowMakerSpy {
        return KeyWindowMakerSpy(inheriting: inherited)
    }
}



public final class KeyWindowMaker: KeyWindowMakerProtocol {
    private let window: WeakOrUnowned<UIWindow>


    public init(modifying window: WeakOrUnowned<UIWindow>) {
        self.window = window
    }


    public func makeKey() {
        switch self.window {
        case .weakReference(let weak):
            weak.do { window in
                window?.makeKey()
            }
        case .unownedReference(let unowned):
            unowned.do { window in
                window.makeKey()
            }
        }
    }


    public func makeKeyAndVisible() {
        switch self.window {
        case .weakReference(let weak):
            weak.do { window in
                window?.makeKeyAndVisible()
            }
        case .unownedReference(let unowned):
            unowned.do { window in
                window.makeKeyAndVisible()
            }
        }
    }


    public func becomeKey() {
        switch self.window {
        case .weakReference(let weak):
            weak.do { window in
                window?.becomeKey()
            }
        case .unownedReference(let unowned):
            unowned.do { window in
                window.becomeKey()
            }
        }
    }


    public func resignKey() {
        switch self.window {
        case .weakReference(let weak):
            weak.do { window in
                window?.resignKey()
            }
        case .unownedReference(let unowned):
            unowned.do { window in
                window.resignKey()
            }
        }
    }
}
