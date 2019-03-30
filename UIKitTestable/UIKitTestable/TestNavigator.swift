import UIKit



public final class TestNavigator: NavigatorProtocol {
    private let presenter: GlobalModalPresenterProtocol
    private let keyWindowWriter: KeyWindowMakerProtocol


    public init(
        presentingBy presenter: GlobalModalPresenterProtocol,
        makingKeyWindowBy keyWindowWriter: KeyWindowMakerProtocol
    ) {
        self.presenter = presenter
        self.keyWindowWriter = keyWindowWriter
    }


    public func push(viewController: UIViewController, animated: Bool) {
        self.presenter.present(
            viewController: UINavigationController(rootViewController: viewController),
            animated: animated,
            completion: nil
        )
    }
}
