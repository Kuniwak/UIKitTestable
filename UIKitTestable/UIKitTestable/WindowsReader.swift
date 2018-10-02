import UIKit



public protocol WindowsReaderProtocol {
    var windows: [UIWindow] { get }
}



public final class WindowsReader: WindowsReaderProtocol {
    private let application: UIApplication


    public var windows: [UIWindow] {
        return self.application.windows
    }


    public init(whoHaveWindows application: UIApplication) {
        self.application = application
    }
}