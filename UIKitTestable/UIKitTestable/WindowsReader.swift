import UIKit



/// A protocol for wrapper classes that encapsulate the implementation of `UIApplication#windows`.
public protocol WindowsReaderProtocol {
    /// UIWindows of the given UIApplication.
    var windows: [UIWindow] { get }
}



extension WindowsReaderProtocol {
    /// Returns a stub that do nothing.
    public static func stub(willReturn initialResult: [WeakOrUnownedOrStrong<UIWindow>]) -> WindowsReaderStub {
        return WindowsReaderStub(willReturn: initialResult)
    }
}



/// A class that encapsulate the implementation of `UIApplication#open`.
public final class WindowsReader: WindowsReaderProtocol {
    // NOTE: This should be unowned or weak, because the UIApplication can have UIWindows and the UIWindow can have
    //       an UIViewController as the rootViewController.
    private unowned var application: UIApplication


    /// UIWindows of the given UIApplication.
    public var windows: [UIWindow] {
        return self.application.windows
    }


    /// - parameters:
    ///     - application: The UIApplication has UIWindows.
    public init(whoHaveWindows application: UIApplication) {
        self.application = application
    }
}