import UIKit



/// A stub class for `URLOpener`.
/// This class is useful to prevent side-effects for testing.
/// Given completions can be called manually.
public final class URLOpenerManualStub: URLOpenerProtocol {
    /// A last completion if exists.
    private var completion: ((Bool) -> Void)?


    public init() {}


    /// Does nothing.
    public func open(url: URL) {}


    /// Does nothing.
    public func open(url: URL, completion: @escaping (Bool) -> Void) {
        self.completion = completion
    }


    /// Does nothing.
    public func open(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completion: @escaping (Bool) -> Void) {
        self.completion = completion
    }


    /// Calls the last completion if exists. Otherwise throws a NoSuchCompletions.
    /// - parameters:
    ///     - isSuccess: A Boolean indicating whether the URL was opened successfully.
    /// - throws: NoSuchCompletions.
    public func complete(_ isSuccess: Bool) throws {
        guard let completion = self.completion else {
            throw NoSuchCompletions()
        }
        completion(isSuccess)
    }
}



/// A stub class for `URLOpener`.
/// This class is useful to prevent side-effects for testing.
/// Given completions will be called immediately.
public final class URLOpenerSyncStub: URLOpenerProtocol {
    /// A next callback argument.
    public var nextCallbackArgument: Bool


    /// - parameters:
    ///     - firstCallbackArgument: A next callback argument.
    public init(willCallWith firstCallbackArgument: Bool = false) {
        self.nextCallbackArgument = firstCallbackArgument
    }


    /// Does nothing.
    public func open(url: URL) {}


    /// Does nothing but the completion will be called immediately.
    public func open(url: URL, completion: @escaping (Bool) -> Void) {
        completion(self.nextCallbackArgument)
    }


    /// Does nothing but the completion will be called immediately.
    public func open(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completion: @escaping (Bool) -> Void) {
        completion(self.nextCallbackArgument)
    }
}



/// A stub class for `URLOpener`.
/// This class is useful to prevent side-effects for testing.
/// Given completions will be called asynchronously.
public final class URLOpenerAsyncStub: URLOpenerProtocol {
    /// A next callback argument.
    public var nextCallbackArgument: Bool


    /// - parameters:
    ///     - firstCallbackArgument: A next callback argument.
    public init(willCallWith firstCallbackArgument: Bool) {
        self.nextCallbackArgument = firstCallbackArgument
    }


    /// Does nothing.
    public func open(url: URL) {}


    /// Does nothing but the completion will be called asynchronously.
    public func open(url: URL, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            completion(self.nextCallbackArgument)
        }
    }


    /// Does nothing but the completion will be called asynchronously.
    public func open(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            completion(self.nextCallbackArgument)
        }
    }
}



/// A stub class for `URLOpener`.
/// This class is useful to prevent side-effects for testing.
/// Given completions will be never called.
public final class URLOpenerNeverStub: URLOpenerProtocol {
    public init() {}


    /// Does nothing.
    public func open(url: URL) {}


    /// Does nothing but the completion will be never called.
    public func open(url: URL, completion: @escaping (Bool) -> Void) {}


    /// Does nothing but the completion will be never called.
    public func open(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completion: @escaping (Bool) -> Void) {}
}
