import UIKit



public protocol WindowsReaderProtocol {
    var windows: [UIWindow] { get }
}



extension WindowsReaderProtocol {
    /// Returns a stub that do nothing.
    public static func stub(willReturn initialResult: [WeakOrUnownedOrStrong<UIWindow>]) -> WindowsReaderStub {
        return WindowsReaderStub(willReturn: initialResult)
    }
}



public final class WindowsReader: WindowsReaderProtocol {
    private unowned var application: UIApplication


    public var windows: [UIWindow] {
        return self.application.windows
    }


    public init(whoHaveWindows application: UIApplication) {
        self.application = application
    }
}