import UIKit



/**
 A type for wrapper classes that encapsulate an implementation of `UIApplication#open`.
 */
public protocol URLOpenerProtocol {
    /**
     Attempts to open the resource at the specified URL.
     This method behave like `UIApplication#openURL`.
     */
    func open(url: URL)


    /**
     Attempts to open the resource at the specified URL.
     This method behave like `UIApplication#open`.
     */
    @available(iOS 10.0, *)
    func open(url: URL, completion: @escaping (Bool) -> Void)


    /**
     Attempts to open the resource at the specified URL.
     This method behave like `UIApplication#open`.
     */
    @available(iOS 10.0, *)
    func open(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completion: @escaping (Bool) -> Void)
}


/**
 A wrapper class to encapsulate a implementation of `UIApplication#open`.
 You can replace the class to the stub or spy for testing.
 */
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
