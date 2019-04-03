import UIKit



public protocol WindowsReaderProtocol {
    var windows: [UIWindow] { get }
}



extension WindowsReaderProtocol {
    public static func stub(willReturn initialResult: [WeakOrUnownedOrStrong<UIWindow>]) -> WindowsReaderStub {
        return WindowsReaderStub(willReturn: initialResult)
    }


    public static func spy(inheriting inherited: WindowsReaderProtocol = WindowsReaderStub()) -> WindowsReaderSpy {
        return WindowsReaderSpy(inheriting: inherited)
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