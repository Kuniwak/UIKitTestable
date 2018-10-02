import UIKit


public protocol GlobalModalPresenterProtocol: ModalPresenterProtocol {}



/**
 A class for specialized ModalPresenters that can present a UIViewController unconditionally.
 You can present a UIViewController if you does not know what UIViewController is visible.
 */
public class GlobalModalPresenter {
    private let rootViewControllerReadWriter: RootViewControllerReadWriterProtocol
    private let keyWindowWriter: KeyWindowMakerProtocol


    public convenience init(wherePresentOn window: UIWindow) {
        self.init(
            alteringRootViewControllerBy: WindowRootViewControllerReadWriter(readingAndWriting: window),
            makingKeyWindowBy: KeyWindowMaker(modifying: window)
        )
    }


    public init(
        alteringRootViewControllerBy rootViewControllerReadWriter: RootViewControllerReadWriterProtocol,
        makingKeyWindowBy keyWindowWriter: KeyWindowMakerProtocol
    ) {
        self.rootViewControllerReadWriter = rootViewControllerReadWriter
        self.keyWindowWriter = keyWindowWriter
    }
}



extension GlobalModalPresenter: GlobalModalPresenterProtocol {
    public func present(viewController: UIViewController, animated: Bool) {
        self.present(viewController: viewController, animated: animated, completion: nil)
    }


    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.keyWindowWriter.makeKeyAndVisible()
        let rootViewController = GlobalModalBackgroundViewController() { appearedViewController in
            appearedViewController.present(
                viewController,
                animated: animated,
                completion: completion
            )
        }
        self.rootViewControllerReadWriter.alter(to: rootViewController)
    }
}



extension GlobalModalPresenter: GlobalModalDissolverProtocol {
    public func dismiss(animated: Bool) {
        self.dismiss(animated: animated, completion: nil)
    }


    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        guard let rootViewController = self.rootViewControllerReadWriter.rootViewController else { return }

        rootViewController.dismiss(animated: animated, completion: completion)
    }
}
