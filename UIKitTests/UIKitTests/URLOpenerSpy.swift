import UIKit
import UIKitTestable



/**
 A spy class for UrlOpener.
 This class is useful for capturing calls of `UIApplication#open` for testing.
 */
public class URLOpenerSpy: URLOpenerProtocol {
    /**
     Call arguments list for the method `#open(url: URL)`.
     You can use the property to test how the method is called.
     */
    public private(set) var callArgs = [URL]()
    public var delegate: URLOpenerProtocol


    public init(inheriting delegate: URLOpenerProtocol = URLOpenerStub()) {
        self.delegate = delegate
    }


    public func open(url: URL) {
        self.callArgs.append(url)

        self.delegate.open(url: url)
    }
}
