import UIKit



/// A spy class for `URLOpener`s.
/// This class is useful for capturing calls of `UIApplication#open` for testing.
public final class URLOpenerSpy: URLOpenerProtocol {
    /// Call arguments of methods of `URLOpenerSpy`.
    public enum CallArgs: Equatable {
        case open(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any]?)


        public static func ==(lhs: CallArgs, rhs: CallArgs) -> Bool {
            switch (lhs, rhs) {
            case (.open(url: let lu, options: .none), .open(url: let ru, options: .none)):
                return lu == ru

            case (.open(url: let lu, options: .some(let lo)), .open(url: let ru, options: .some(let ro))):
                // XXX: Any is not an Equatable, but we can roughly compare by the debugDescription.
                let loEquatable = lo.mapValues { "\($0)" }
                let roEquatable = ro.mapValues { "\($0)" }
                return lu == ru && loEquatable == roEquatable

            default:
                return false
            }
        }
    }


    /// Captured call arguments list for methods.
    /// You can use the property to verify how methods were called.
    public private(set) var callArgs = [CallArgs]()


    /// A dynamic base class that can control how the last completion is called.
    public var inherited: URLOpenerProtocol


    /// - parameters:
    ///     - inherited: A dynamic base class that can control how the last completion is called. Default is never called.
    public init(inheriting inherited: URLOpenerProtocol = URLOpenerNeverStub()) {
        self.inherited = inherited
    }


    /// Records the call arguments and calls the dynamic base class.
    public func open(url: URL) {
        self.callArgs.append(.open(url: url, options: nil))

        self.inherited.open(url: url)
    }


    /// Records the call arguments and calls the dynamic base class.
    public func open(url: URL, completion: @escaping (Bool) -> Void) {
        self.callArgs.append(.open(url: url, options: nil))

        self.inherited.open(url: url, completion: completion)
    }


    /// Records the call arguments and calls the dynamic base class.
    public func open(url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completion: @escaping (Bool) -> Void) {
        self.callArgs.append(.open(url: url, options: options))

        self.inherited.open(url: url, options: options, completion: completion)
    }
}
