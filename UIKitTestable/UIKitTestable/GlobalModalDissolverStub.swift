import UIKit



public class GlobalModalDissolverStub: GlobalModalDissolverProtocol {
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



public class GlobalModalDissolverSyncStub: GlobalModalDissolverProtocol {
    public init() {}


    public func dismiss(animated: Bool) {}
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        completion?()
    }
}



public class GlobalModalDissolverAsyncStub: GlobalModalDissolverProtocol {
    public init() {}


    public func dismiss(animated: Bool) {}
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            completion?()
        }
    }
}



public class GlobalModalDissolverNeverStub: GlobalModalDissolverProtocol {
    public init() {}


    public func dismiss(animated: Bool) {}
    public func dismiss(animated: Bool, completion: (() -> Void)?) {}
}
