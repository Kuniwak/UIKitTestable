import UIKit



/**
 A spy class for ModalPresenters.
 This class is useful for capturing calls of `UIViewController#present` for testing.
 */
public class ModalPresenterSpy: ModalPresenterProtocol {
    public typealias CallArgs = (viewController: UIViewController, animated: Bool, completion: (() -> Void)?)


    /**
     Call arguments list for the method `present`.
     You can use the property to test how the method is called.
     */
    public fileprivate(set) var callArgs: [CallArgs] = []

    public var delegate: ModalPresenterProtocol


    public init(delegating delegate: ModalPresenterProtocol = ModalPresenterStub()) {
        self.delegate = delegate
    }


    public func present(viewController: UIViewController, animated: Bool) {
        let callArgs: CallArgs = (viewController: viewController, animated: animated, completion: nil)
        self.callArgs.append(callArgs)

        self.delegate.present(viewController: viewController, animated: animated)
    }


    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        let callArgs: CallArgs = (viewController: viewController, animated: animated, completion: completion)
        self.callArgs.append(callArgs)

        self.delegate.present(viewController: viewController, animated: animated, completion: completion)
    }
}
