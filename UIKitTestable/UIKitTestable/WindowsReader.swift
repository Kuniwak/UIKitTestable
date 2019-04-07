import UIKit



/// A protocol for wrapper classes that encapsulate the implementation of `UIApplication#windows`.
/// You can use some stubs or spies instead of actual classes for testing.
/// - SeeAlso: `WindowsReaderUsages`
public protocol WindowsReaderProtocol {
    /// UIWindows of the given UIApplication.
    var windows: [UIWindow] { get }
}



/// Returns a stub that do nothing.
public func stub(willReturn initialResult: [WeakOrUnownedOrStrong<UIWindow>]) -> WindowsReaderStub {
    return WindowsReaderStub(willReturn: initialResult)
}



/// A class that encapsulate the implementation of `UIApplication#open`.
/// You can replace the class with the stub or spy for testing.
/// - SeeAlso: `WindowsReaderUsages`
public final class WindowsReader: WindowsReaderProtocol {
    // NOTE: This should be unowned or weak, because the UIApplication can have UIWindows and the UIWindow can have
    //       an UIViewController as the rootViewController.
    private unowned var application: UIApplication


    /// UIWindows of the given UIApplication.
    public var windows: [UIWindow] {
        return self.application.windows
    }


    /// - Parameters:
    ///     - application: The UIApplication has UIWindows.
    public init(whoHaveWindows application: UIApplication) {
        self.application = application
    }
}