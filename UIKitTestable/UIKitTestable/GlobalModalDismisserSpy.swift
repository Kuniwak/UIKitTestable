import UIKit



/// A spy class for `GlobalModalDismisser`s.
/// This class captures calls of methods of the class for testing.
/// - SeeAlso: `GlobalModalDismisserUsages`.
public final class GlobalModalDismisserSpy: GlobalModalDismisserProtocol {
    /// Call arguments of methods of `GlobalModalDismisserSpy`.
    public enum CallArgs: Equatable {
        case dismiss(animated: Bool)
    }


    /// Captured call arguments list for methods of `GlobalModalDismisser`.
    /// You can use the property to verify how the method is called.
    public private(set) var callArgs = [CallArgs]()


    /// A dynamic base class that can control how the last completion is called.
    public var inherited: GlobalModalDismisserProtocol


    /// Returns a newly initialized spy.`
    /// - Parameters:
    ///     - inherited: A base class that can control when the last completion is called.
    public init(inheriting inherited: GlobalModalDismisserProtocol = GlobalModalDismisserNeverStub()) {
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
