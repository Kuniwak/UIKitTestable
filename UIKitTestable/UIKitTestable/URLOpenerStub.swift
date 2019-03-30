import UIKit



/**
 A stub class for URLOpener.
 This class is useful for ignoring calls of `UIApplication#open` for testing.

 You can call the completion callback of `open` by calling `complete(isSuccess:Book)`.
 */
public final class URLOpenerStub: URLOpenerProtocol {
    private var completion: ((Bool) -> Void)?


    public init() {}


    public func open(url: URL) {}


    public func open(url: URL, completion: @escaping (Bool) -> Void) {
        self.completion = completion
    }


    public func open(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completion: @escaping (Bool) -> Void) {
        self.completion = completion
    }


    public func complete(isSuccess: Bool) {
        self.completion?(isSuccess)
    }
}



/**
 A stub class for URLOpener.
 This class is useful for ignoring calls of `UIApplication#open` for testing.

 The completion callback of `open` will be called synchronously.
 */
public final class URLOpenerSyncStub: URLOpenerProtocol {
    public var nextCallbackArgument: Bool


    public init(willCallWith firstCallbackArgument: Bool) {
        self.nextCallbackArgument = firstCallbackArgument
    }


    public func open(url: URL) {}


    public func open(url: URL, completion: @escaping (Bool) -> Void) {
        completion(self.nextCallbackArgument)
    }


    public func open(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completion: @escaping (Bool) -> Void) {
        completion(self.nextCallbackArgument)
    }
}



/**
 A stub class for URLOpener.
 This class is useful for ignoring calls of `UIApplication#open` for testing.

 The completion callback of `open` will be called asynchronously.
 */
public final class URLOpenerAsyncStub: URLOpenerProtocol {
    public var nextCallbackArgument: Bool


    public init(willCallWith firstCallbackArgument: Bool) {
        self.nextCallbackArgument = firstCallbackArgument
    }


    public func open(url: URL) {}


    public func open(url: URL, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            completion(self.nextCallbackArgument)
        }
    }


    public func open(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            completion(self.nextCallbackArgument)
        }
    }
}



/**
 A stub class for URLOpener.
 This class is useful for ignoring calls of `UIApplication#open` for testing.

 The completion callback of `open` will be never called.
 */
public final class URLOpenerNeverStub: URLOpenerProtocol {
    public init() {}


    public func open(url: URL) {}
    public func open(url: URL, completion: @escaping (Bool) -> Void) {}
    public func open(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completion: @escaping (Bool) -> Void) {}
}
