import UIKit
import UIKitTestable



/**
 A stub class for UrlOpener.
 This class is useful for ignoring calls of `UIApplication#open` for testing.
 */
public class URLOpenerStub: URLOpenerProtocol {
    public init() {}


    public func open(url: URL) {}
}
