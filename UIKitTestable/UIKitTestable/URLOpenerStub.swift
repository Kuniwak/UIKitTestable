import UIKit



/// A stub class for `URLOpener`.
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions can be called manually.
/// - SeeAlso: `URLOpenerUsages`
public final class URLOpenerManualStub: URLOpenerProtocol {
    /// A last completion if exists.
    private var completion: ((Bool) -> Void)?


    /// Returns a newly initialized stub.`
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
    /// - Parameters:
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
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions will be called immediately.
/// - SeeAlso: `URLOpenerUsages`
public final class URLOpenerSyncStub: URLOpenerProtocol {
    /// A next callback argument.
    public var nextCallbackArgument: Bool


    /// Returns a newly initialized stub.`
    /// - Parameters:
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
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions will be called asynchronously.
/// - SeeAlso: `URLOpenerUsages`
public final class URLOpenerAsyncStub: URLOpenerProtocol {
    /// A next callback argument.
    public var nextCallbackArgument: Bool


    /// Returns a newly initialized stub.`
    /// - Parameters:
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
/// This class does nothing so it is useful to prevent side-effects for testing.
/// Given completions will be never called.
/// - SeeAlso: `URLOpenerUsages`
public final class URLOpenerNeverStub: URLOpenerProtocol {
    /// Returns a newly initialized stub.`
    public init() {}


    /// Does nothing.
    public func open(url: URL) {}


    /// Does nothing but the completion will be never called.
    public func open(url: URL, completion: @escaping (Bool) -> Void) {}


    /// Does nothing but the completion will be never called.
    public func open(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completion: @escaping (Bool) -> Void) {}
}
