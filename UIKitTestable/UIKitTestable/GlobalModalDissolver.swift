import UIKit


/// A protocol for dismissing global modals.
public protocol GlobalModalDissolverProtocol: ModalDissolverProtocol {}



extension GlobalModalDissolverProtocol {
    public static func stub() -> GlobalModalDissolverStub {
        return GlobalModalDissolverStub()
    }


    public static func syncStub() -> GlobalModalDissolverSyncStub {
        return GlobalModalDissolverSyncStub()
    }


    public static func asyncStub() -> GlobalModalDissolverAsyncStub {
        return GlobalModalDissolverAsyncStub()
    }


    public static func never() -> GlobalModalDissolverNeverStub {
        return GlobalModalDissolverNeverStub()
    }


    public static func spy(
        inheriting inherited: GlobalModalDissolverProtocol = GlobalModalDissolverSyncStub()
    ) -> GlobalModalDissolverSpy {
        return GlobalModalDissolverSpy(inheriting: inherited)
    }
}
