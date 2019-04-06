import UIKit


/// A protocol for specialized ModalPresenters that can present a UIViewController on a top of view hierarchy unconditionally.
public protocol GlobalModalPresenterProtocol: ModalPresenterProtocol {}



extension GlobalModalPresenterProtocol {
    /// Returns a stub that can call a last completion manually.
    public static func manualStub() -> GlobalModalPresenterManualStub {
        return GlobalModalPresenterManualStub()
    }


    /// Returns a stub that call the given completion immediately.
    public static func syncStub() -> GlobalModalPresenterSyncStub {
        return GlobalModalPresenterSyncStub()
    }


    /// Returns a stub that call the given completion asynchronously.
    public static func asyncStub() -> GlobalModalPresenterAsyncStub {
        return GlobalModalPresenterAsyncStub()
    }


    /// Returns a stub that will never call the given completion.
    public static func neverStub() -> GlobalModalPresenterNeverStub {
        return GlobalModalPresenterNeverStub()
    }


    /// Returns a spy that record how methods were called.
    /// - parameters:
    ///     - inherited: A dynamic base class control how call a completion.
    public static func spy(
        inheriting inherited: GlobalModalPresenterProtocol = GlobalModalPresenterNeverStub()
    ) -> GlobalModalPresenterSpy {
        return GlobalModalPresenterSpy(inheriting: inherited)
    }
}



/// A class for specialized ModalPresenters that can present a UIViewController on a top of view hierarchy unconditionally.
/// You can present a UIViewController if you does not know what UIViewController is visible.
public final class GlobalModalPresenter {
    private let rootViewControllerReadWriter: RootViewControllerReadWriterProtocol
    private let keyWindowWriter: KeyWindowMakerProtocol


    /// - parameters:
    ///     - window: The UIWindow where given UIViewControllers present on.
    public convenience init(wherePresentOn window: WeakOrUnowned<UIWindow>) {
        self.init(
            alteringRootViewControllerBy: WindowRootViewControllerReadWriter(readingAndWriting: window),
            makingKeyWindowBy: KeyWindowMaker(modifying: window)
        )
    }


    /// - parameters:
    ///     - rootViewControllerReadWriter: An object has a rootViewController.
    ///     - kwyWindowWriter: An object that can make a UIWindow to the key.
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
