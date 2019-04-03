import UIKit



public final class RootViewControllerReaderSpy: RootViewControllerReaderProtocol {
    public enum CallArgs: Equatable {
        case rootViewController
    }


    public private(set) var callArgs = [CallArgs]()
    private var inherited: RootViewControllerReaderProtocol


    public var rootViewController: UIViewController? {
        self.callArgs.append(.rootViewController)

        return self.inherited.rootViewController
    }


    public init(inheriting inherited: RootViewControllerReaderProtocol) {
        self.inherited = inherited
    }
}
