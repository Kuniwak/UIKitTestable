import UIKit



/// A stub class for `RootViewControllerReadWriter`.
/// This class is useful to prevent side-effects for testing.
/// Given completions can be called manually.
public final class RootViewControllerReadWriterManualStub: RootViewControllerReadWriterProtocol {
    /// An UIViewController that will be returned as rootViewController.
    public var nextResult: WeakOrUnownedOrStrong<UIViewController>


    /// A last completion if exists.
    private var completion: (() -> Void)?


    /// A root ViewController. The returned value can be changed by `nextResult`.
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


    /// - parameters:
    ///     - initialResult: An UIViewController that will be returned as rootViewController.
    public init(willReturn initialResult: WeakOrUnownedOrStrong<UIViewController> = .empty()) {
        self.nextResult = initialResult
    }


    /// Does nothing.
    public func alter(to rootViewController: UIViewController) {}


    /// Does nothing but the completion can be called by `complete`.
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        self.completion = completion
    }


    /// Calls the last completion if exists. Otherwise throws a NoSuchCompletions.
    /// - throws: NoSuchCompletions.
    public func complete() throws {
        guard let completion = self.completion else {
            throw NoSuchCompletions()
        }
        completion()
    }
}



/// A stub class for `RootViewControllerReadWriter`.
/// This class is useful to prevent side-effects for testing.
/// Given completions will be called immediately.
public final class RootViewControllerReadWriterSyncStub: RootViewControllerReadWriterProtocol {
    /// An UIViewController that will be returned as rootViewController.
    public var nextResult: WeakOrUnownedOrStrong<UIViewController>


    /// A root ViewController. The returned value can be changed by `nextResult`.
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


    /// - parameters:
    ///     - initialResult: An UIViewController that will be returned as rootViewController.
    public init(willReturn initialResult: WeakOrUnownedOrStrong<UIViewController> = .empty()) {
        self.nextResult = initialResult
    }


    /// Does nothing.
    public func alter(to rootViewController: UIViewController) {}


    /// Does nothing but the completion will be called immediately.
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        completion?()
    }
}



/// A stub class for `RootViewControllerReadWriter`.
/// This class is useful to prevent side-effects for testing.
/// Given completions will be called asynchronously.
public final class RootViewControllerReadWriterAsyncStub: RootViewControllerReadWriterProtocol {
    /// An UIViewController that will be returned as rootViewController.
    public var nextResult: WeakOrUnownedOrStrong<UIViewController>


    /// A root ViewController. The returned value can be changed by `nextResult`.
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


    /// - parameters:
    ///     - initialResult: An UIViewController that will be returned as rootViewController.
    public init(willReturn initialResult: WeakOrUnownedOrStrong<UIViewController> = .empty()) {
        self.nextResult = initialResult
    }


    /// Does nothing.
    public func alter(to rootViewController: UIViewController) {}


    /// Does nothing but the completion will be called asynchronously.
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            completion?()
        }
    }
}



/// A stub class for `RootViewControllerReadWriter`.
/// This class is useful to prevent side-effects for testing.
/// Given completions will be never called.
public final class RootViewControllerReadWriterNeverStub: RootViewControllerReadWriterProtocol {
    /// An UIViewController that will be returned as rootViewController.
    public var nextResult: WeakOrUnownedOrStrong<UIViewController>


    /// A root ViewController. The returned value can be changed by `nextResult`.
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


    /// - parameters:
    ///     - initialResult: An UIViewController that will be returned as rootViewController.
    public init(willReturn initialResult: WeakOrUnownedOrStrong<UIViewController> = .empty()) {
        self.nextResult = initialResult
    }


    /// Does nothing.
    public func alter(to rootViewController: UIViewController) {}
    
    
    /// Does nothing and the completion will be never called.
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {}
}
