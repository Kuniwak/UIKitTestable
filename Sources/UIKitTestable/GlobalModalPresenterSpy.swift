import UIKit



/**
 A spy class for GlobalModalPresenter.
 This class is useful for capturing calls of `GlobalModalPresenter#present` for testing.
 */
public class GlobalModalPresenterSpy: GlobalModalPresenterProtocol {
    public typealias CallArgs = (viewController: UIViewController, animated: Bool, completion: (() -> Void)?)


    /**
     Call arguments list for the method `GlobalModalPresenter#present`.
     You can use the property to test how the method is called.
     */
    public fileprivate(set) var callArgs: [CallArgs] = []


    public var inherited: GlobalModalPresenterProtocol


    public var dissolver: ModalDissolverProtocol {
        return self.inherited.dissolver
    }


    public init(inherit inherited: GlobalModalPresenterProtocol) {
        self.inherited = inherited
    }


    public func present(
        viewController: UIViewController,
        animated: Bool
    ) {
        self.present(
            viewController: viewController,
            animated: animated,
            completion: nil
        )
    }


    public func present(
        viewController: UIViewController,
        animated: Bool,
        completion: (() -> Void)?
    ) {
        self.callArgs.append((
            viewController: viewController,
            animated: animated,
            completion: completion
        ))

        self.inherited.present(
            viewController: viewController,
            animated: animated,
            completion: completion
        )
    }
}
