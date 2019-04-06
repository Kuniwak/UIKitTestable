import UIKit



public final class RootViewControllerReadWriterManualStub: RootViewControllerReadWriterProtocol {
    public var nextResult: WeakOrUnownedOrStrong<UIViewController>
    private var completion: (() -> Void)?


    public var rootViewController: UIViewController? {
        switch self.nextResult {
        case .weakReference(let weak):
            return weak.value
        case .unownedReference(let unowned):
            return unowned.value
        case .strongReference(let strong):
            return strong.value
        }
    }


    public init(willReturn initialResult: WeakOrUnownedOrStrong<UIViewController> = .empty()) {
        self.nextResult = initialResult
    }


    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        self.completion = completion
    }


    public func complete() {
        self.completion?()
    }
}



public final class RootViewControllerReadWriterSyncStub: RootViewControllerReadWriterProtocol {
    public var nextResult: WeakOrUnownedOrStrong<UIViewController>
    private var completion: (() -> Void)?


    public var rootViewController: UIViewController? {
        switch self.nextResult {
        case .weakReference(let weak):
            return weak.value
        case .unownedReference(let unowned):
            return unowned.value
        case .strongReference(let strong):
            return strong.value
        }
    }


    public init(willReturn initialResult: WeakOrUnownedOrStrong<UIViewController> = .empty()) {
        self.nextResult = initialResult
    }


    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        completion?()
    }
}



public final class RootViewControllerReadWriterAsyncStub: RootViewControllerReadWriterProtocol {
    public var nextResult: WeakOrUnownedOrStrong<UIViewController>
    private var completion: (() -> Void)?


    public var rootViewController: UIViewController? {
        switch self.nextResult {
        case .weakReference(let weak):
            return weak.value
        case .unownedReference(let unowned):
            return unowned.value
        case .strongReference(let strong):
            return strong.value
        }
    }


    public init(willReturn initialResult: WeakOrUnownedOrStrong<UIViewController> = .empty()) {
        self.nextResult = initialResult
    }


    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            completion?()
        }
    }
}



public final class RootViewControllerReadWriterNeverStub: RootViewControllerReadWriterProtocol {
    public var nextResult: WeakOrUnownedOrStrong<UIViewController>
    private var completion: (() -> Void)?


    public var rootViewController: UIViewController? {
        switch self.nextResult {
        case .weakReference(let weak):
            return weak.value
        case .unownedReference(let unowned):
            return unowned.value
        case .strongReference(let strong):
            return strong.value
        }
    }


    public init(willReturn initialResult: WeakOrUnownedOrStrong<UIViewController> = .empty()) {
        self.nextResult = initialResult
    }


    public func alter(to rootViewController: UIViewController) {}
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {}
}
