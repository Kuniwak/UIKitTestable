import UIKit



public final class GlobalModalDissolverStub: GlobalModalDissolverProtocol {
    private var completion: (() -> Void)?


    public init() {}


    public func dismiss(animated: Bool) {}
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.completion = completion
    }


    public func complete() {
        self.completion?()
    }
}



public final class GlobalModalDissolverSyncStub: GlobalModalDissolverProtocol {
    public init() {}


    public func dismiss(animated: Bool) {}
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
}



public final class GlobalModalDissolverAsyncStub: GlobalModalDissolverProtocol {
    public init() {}


    public func dismiss(animated: Bool) {}
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            completion?()
        }
    }
}



public final class GlobalModalDissolverNeverStub: GlobalModalDissolverProtocol {
    public init() {}


    public func dismiss(animated: Bool) {}
    public func dismiss(animated: Bool, completion: (() -> Void)?) {}
}
