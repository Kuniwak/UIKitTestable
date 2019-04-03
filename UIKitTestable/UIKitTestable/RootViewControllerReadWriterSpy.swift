import UIKit



public final class RootViewControllerReadWriterSpy: RootViewControllerReadWriterProtocol {
    public enum CallArgs: Equatable {
        case rootViewController
        case alter(rootViewController: UIViewController)
    }


    public private(set) var callArgs = [CallArgs]()
    public var inherited: RootViewControllerReadWriterProtocol


    public var rootViewController: UIViewController? {
        self.callArgs.append(.rootViewController)

        return self.inherited.rootViewController
    }


    public init(inheriting inherited: RootViewControllerReadWriterProtocol) {
        self.inherited = inherited
    }


    public func alter(to rootViewController: UIViewController) {
        self.callArgs.append(.alter(rootViewController: rootViewController))

        self.inherited.alter(to: rootViewController)
    }


    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        self.callArgs.append(.alter(rootViewController: rootViewController))

        self.inherited.alter(to: rootViewController, completion: completion)
    }
}
