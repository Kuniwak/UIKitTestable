import UIKit
import UIKitTestable



/**
 A spy class for ModalPresenters.
 This class is useful for capturing calls of `UIViewController#present` for testing.
 */
public final class ModalPresenterSpy: ModalPresenterProtocol {
    public enum CallArgs: Equatable {
        case present(viewController: UIViewController, animated: Bool)
    }


    /**
     Call arguments list for the method `present`.
     You can use the property to test how the method is called.
     */
    public private(set) var callArgs: [CallArgs] = []

    public var delegate: ModalPresenterProtocol


    public init(delegating delegate: ModalPresenterProtocol = ModalPresenterStub()) {
        self.delegate = delegate
    }


    public func present(viewController: UIViewController, animated: Bool) {
        self.callArgs.append(.present(viewController: viewController, animated: animated))

        self.delegate.present(viewController: viewController, animated: animated)
    }


    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.callArgs.append(.present(viewController: viewController, animated: animated))

        self.delegate.present(viewController: viewController, animated: animated, completion: completion)
    }
}
