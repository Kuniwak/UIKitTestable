import UIKit



/// A spy class for `ModalDismisser`s.
/// This class captures calls of methods of the class for testing.
/// - SeeAlso: [`ModalDismisserUsages`](https://kuniwak.github.io/UIKitTestable/UIKitTestableAppTests/Classes/ModalDismisserUsages.html).
public final class ModalDismisserSpy: ModalDismisserProtocol {
    /// Call arguments of methods of `ModalDismisserSpy`.
    public enum CallArgs: Equatable {
        case dismiss(animated: Bool)
    }


    /// Captured call arguments list for methods.
    /// You can use the property to verify how methods were called.
    public private(set) var callArgs: [CallArgs] = []


    /// A dynamic base class that can control how the last completion is called.
    public var inherited: ModalDismisserProtocol


    /// Returns a newly initialized spy.`
    /// - Parameters:
    ///     - inherited: A dynamic base class that can control how the last completion is called.
    public init(inheriting inherited: ModalDismisserProtocol = ModalDismisserNeverStub()) {
        self.inherited = inherited
    }


    /// Records the call arguments and calls the dynamic base class.
    public func dismiss(animated: Bool) {
        self.callArgs.append(.dismiss(animated: animated))

        self.inherited.dismiss(animated: animated)
    }


    /// Records the call arguments and calls the dynamic base class.
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.callArgs.append(.dismiss(animated: animated))

        self.inherited.dismiss(animated: animated, completion: completion)
    }
}
