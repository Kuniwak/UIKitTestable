/// A mix-in class between `GlobalModalPresenterProtocol` and `GlobalModalDismisserProtocol`.
/// This class does not have variations for any stubs or spies because these variations
/// can be created using stubs and spies for each global presenter and dismisser.
/// - SeeAlso: `WindowModalPresentDismisser`.
public final class GlobalModalPresentDismisser {
    /// A delegated `GlobalModalPresenter`.
    public var globalPresenter: GlobalModalPresenterProtocol


    /// A delegated `GlobalModalDismisser`.
    public var globalDismisser: GlobalModalDismisserProtocol


    /// Returns a newly initialized `GlobalModalPresentDismisser`.
    /// - Parameters:
    ///     - globalPresenter: A delegated `GlobalModalPresenter`.
    ///     - globalDismisser: A delegated `GlobalModalDismisser`.
    public init(
        presentingBy globalPresenter: GlobalModalPresenterProtocol,
        dismissingBy globalDismisser: GlobalModalDismisserProtocol
    ) {
        self.globalPresenter = globalPresenter
        self.globalDismisser = globalDismisser
    }
}



extension GlobalModalPresentDismisser: GlobalModalPresenterProtocol {
    /// Delegates to the `globalPresenter`.
    public func present(viewController: UIViewController, animated: Bool) {
        self.globalPresenter.present(viewController: viewController, animated: animated)
    }


    /// Delegates to the `globalPresenter`.
    public func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.globalPresenter.present(viewController: viewController, animated: animated, completion: completion)
    }
}



extension GlobalModalPresentDismisser: GlobalModalDismisserProtocol {
    /// Delegates to the `globalDismisser`.
    public func dismiss(animated: Bool) {
        self.globalDismisser.dismiss(animated: animated)
    }


    /// Delegates to the `globalDismisser`.
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.globalDismisser.dismiss(animated: animated, completion: completion)
    }
}