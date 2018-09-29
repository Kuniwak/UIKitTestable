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

    public var stub: ModalPresenterProtocol


    public init(inheriting stub: ModalPresenterProtocol) {
        self.stub = stub
    }


    public func present(viewController: UIViewController, animated: Bool) {
        self.stub.present(viewController: viewController, animated: animated)

        let callArgs: CallArgs = (viewController: viewController, animated: animated, completion: nil)
        self.callArgs.append(callArgs)
    }


    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.stub.present(viewController: viewController, animated: animated, completion: completion)

        let callArgs: CallArgs = (viewController: viewController, animated: animated, completion: completion)
        self.callArgs.append(callArgs)
    }
}
