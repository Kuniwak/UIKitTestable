import UIKit



/// A type for wrapper classes that encapsulate an implementation of `UIApplication#open`.
/// - SeeAlso: `URLOpenerUsages`
public protocol URLOpenerProtocol {
    /// Attempts to open the resource at the specified URL.
    /// This method behave like `UIApplication#openURL`.
    func open(url: URL)


    /// Attempts to open the resource at the specified URL.
    /// This method behave like `UIApplication#open`.
    @available(iOS 10.0, *)
    func open(url: URL, completion: @escaping (Bool) -> Void)


    /// Attempts to open the resource at the specified URL.
    /// This method behave like `UIApplication#open`.
    @available(iOS 10.0, *)
    func open(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completion: @escaping (Bool) -> Void)
}



/// Returns a stub that can call a last completion manually.
public func manualStub() -> URLOpenerManualStub {
    return URLOpenerManualStub()
}


/// Returns a stub that call the given completion immediately.
public func syncStub(willCallWith firstCallbackArgument: Bool = true) -> URLOpenerSyncStub {
    return URLOpenerSyncStub(willCallWith: firstCallbackArgument)
}


/// Returns a stub that call the given completion asynchronously.
public func asyncStub(willCallWith firstCallbackArgument: Bool = true) -> URLOpenerAsyncStub {
    return URLOpenerAsyncStub(willCallWith: firstCallbackArgument)
}


/// Returns a stub that will never call the given completion.
public func neverStub() -> URLOpenerNeverStub {
    return URLOpenerNeverStub()
}


/// Returns a spy that record how methods were called.
/// - Parameters:
///     - inherited: A dynamic base class control how call a completion.
public func spy(inheriting inherited: URLOpenerProtocol = URLOpenerNeverStub()) -> URLOpenerSpy {
    return URLOpenerSpy(inheriting: inherited)
}



/// A wrapper class to encapsulate a implementation of `UIApplication#open`.
/// You can replace the class to the stub or spy for testing.
/// - SeeAlso: `URLOpenerUsages`
public final class ApplicationURLOpener: URLOpenerProtocol {
    public func open(url: URL) {
        if #available(iOS 10.0, *) {
            // NOTE: For iOS 10.0+.
            // https://developer.apple.com/reference/uikit/uiapplication/1648685-open
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else {
            // NOTE: For iOS 2.0–10.0.
            // https://developer.apple.com/reference/uikit/uiapplication/1622961-openurl#parameters
            UIApplication.shared.openURL(url)
        }
    }


    @available(iOS 10.0, *)
    public func open(url: URL, completion: @escaping (Bool) -> Void) {
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }


    @available(iOS 10.0, *)
    public func open(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completion: @escaping (Bool) -> Void) {
        UIApplication.shared.open(url, options: options, completionHandler: completion)
    }
}
