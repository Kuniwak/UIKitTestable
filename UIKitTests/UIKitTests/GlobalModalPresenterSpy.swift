import UIKit
import UIKitTestable



/**
 A spy class for GlobalModalPresenter.
 This class is useful for capturing calls of `GlobalModalPresenter#present` for testing.
 */
public class GlobalModalPresenterSpy: GlobalModalPresenterProtocol {
    public enum CallArgs: Equatable {
        case present(viewController: UIViewController, animated: Bool)
    }


    /**
     Call arguments list for the method `GlobalModalPresenter#present`.
     You can use the property to test how the method is called.
     */
    public private(set) var callArgs: [CallArgs] = []


    public var delegate: GlobalModalPresenterProtocol


    public init(inherit delegate: GlobalModalPresenterProtocol) {
        self.delegate = delegate
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
        self.callArgs.append(.present(
            viewController: viewController,
            animated: animated
        ))

        self.delegate.present(
            viewController: viewController,
            animated: animated,
            completion: completion
        )
    }
}
