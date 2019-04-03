import UIKit



/**
 A spy class for UrlOpener.
 This class is useful for capturing calls of `UIApplication#open` for testing.
 */
public final class URLOpenerSpy: URLOpenerProtocol {
    public enum CallArgs: Equatable {
        case open(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any]?)


        public static func ==(lhs: CallArgs, rhs: CallArgs) -> Bool {
            switch (lhs, rhs) {
            case (.open(url: let lu, options: .none), .open(url: let ru, options: .none)):
                return lu == ru

            case (.open(url: let lu, options: .some(let lo)), .open(url: let ru, options: .some(let ro))):
                // XXX: Any is not an Equatable, but we can roughly compare by the debugDescription.
                let loEquatable = lo.mapValues { (value: Any) -> String in "\(value)" }
                let roEquatable = ro.mapValues { (value: Any) -> String in "\(value)" }
                return lu == ru && loEquatable == roEquatable

            default:
                return false
            }
        }
    }


    /**
     Call arguments list for the method `#open(url: URL)`.
     You can use the property to test how the method is called.
     */
    public private(set) var callArgs = [CallArgs]()
    public var inherited: URLOpenerProtocol


    public init(inheriting inherited: URLOpenerProtocol = URLOpenerStub()) {
        self.inherited = inherited
    }


    public func open(url: URL) {
        self.callArgs.append(.open(url: url, options: nil))

        self.inherited.open(url: url)
    }


    public func open(url: URL, completion: @escaping (Bool) -> Void) {
        self.callArgs.append(.open(url: url, options: nil))

        self.inherited.open(url: url, completion: completion)
    }


    public func open(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completion: @escaping (Bool) -> Void) {
        self.callArgs.append(.open(url: url, options: options))

        self.inherited.open(url: url, options: options, completion: completion)
    }
}
