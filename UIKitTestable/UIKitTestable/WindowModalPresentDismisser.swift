import UIKit



/// A class for specialized `ModalPresenter`s that can present a UIViewController on a top of view hierarchy unconditionally.
/// You can present a UIViewController if you does not know what UIViewController is visible.
/// - SeeAlso: `GlobalModalPresenterUsages`.
public final class WindowModalPresentDismisser {
    private let rootViewControllerReadWriter: RootViewControllerReadWriter
    private let keyWindowMaker: KeyWindowMakerProtocol


    /// - Parameters:
    ///     - window: The UIWindow where given UIViewControllers present on.
    public convenience init(wherePresentOn window: WeakOrUnowned<UIWindow>) {
        self.init(
            alteringRootViewControllerBy: RootViewControllerReadWriter(readingAndWriting: window),
            makingKeyWindowBy: KeyWindowMaker(modifying: window)
        )
    }


    /// - Parameters:
    ///     - rootViewControllerReadWriter: An object has a rootViewController.
    ///     - kwyWindowWriter: An object that can make a UIWindow to the key.
    public init(
        alteringRootViewControllerBy rootViewControllerReadWriter: RootViewControllerReadWriter,
        makingKeyWindowBy keyWindowWriter: KeyWindowMakerProtocol
    ) {
        self.rootViewControllerReadWriter = rootViewControllerReadWriter
        self.keyWindowMaker = keyWindowWriter
    }
}



extension WindowModalPresentDismisser: GlobalModalPresenterProtocol {
    /// Presents a view controller modally.
    /// This method behave like `UIViewController#present(UIViewController, animated: Bool)`
    public func present(viewController: UIViewController, animated: Bool) {
        self.present(viewController: viewController, animated: animated, completion: nil)
    }


    /// Presents a view controller modally.
    /// This method behave like `UIViewController#present(UIViewController, animated: Bool, completion: (() -> Void)?)`
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.keyWindowMaker.makeKeyAndVisible()
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



extension WindowModalPresentDismisser: GlobalModalDismisserProtocol {
    /// Dismisses the presented view controller.
    /// This method behave like `UIViewController#dismiss(animated: Bool)`
    public func dismiss(animated: Bool) {
        self.dismiss(animated: animated, completion: nil)
    }


    /// Dismisses the presented view controller.
    /// This method behave like `UIViewController#dismiss(animated: Bool, completion: (() -> Void)?)`
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        guard let rootViewController = self.rootViewControllerReadWriter.rootViewController else { return }

        rootViewController.dismiss(animated: animated, completion: completion)
    }
}
