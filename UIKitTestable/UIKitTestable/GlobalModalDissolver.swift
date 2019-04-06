import UIKit


/// A protocol for dismissing global modals.
public protocol GlobalModalDissolverProtocol: ModalDissolverProtocol {}



extension GlobalModalDissolverProtocol {
    /// Returns a stub that can call a last completion manually.
    public static func manualStub() -> GlobalModalDissolverManualStub {
        return GlobalModalDissolverManualStub()
    }


    /// Returns a stub that call the given completion immediately.
    public static func syncStub() -> GlobalModalDissolverSyncStub {
        return GlobalModalDissolverSyncStub()
    }


    /// Returns a stub that call the given completion asynchronously.
    public static func asyncStub() -> GlobalModalDissolverAsyncStub {
        return GlobalModalDissolverAsyncStub()
    }


    /// Returns a stub that will never call the given completion.
    public static func neverStub() -> GlobalModalDissolverNeverStub {
        return GlobalModalDissolverNeverStub()
    }


    /// Returns a spy that record how methods were called.
    /// - parameters:
    ///     - inherited: A dynamic base class control how call a completion.
    public static func spy(
        inheriting inherited: GlobalModalDissolverProtocol = GlobalModalDissolverNeverStub()
    ) -> GlobalModalDissolverSpy {
        return GlobalModalDissolverSpy(inheriting: inherited)
    }
}
