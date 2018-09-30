import UIKit



public protocol WindowsHolderProtocol {
    var windows: [UIWindow] { get }
}



public class WindowsHolder: WindowsHolderProtocol {
    private let application: UIApplication


    public var windows: [UIWindow] {
        return self.application.windows
    }


    public init(whoHaveWindows application: UIApplication) {
        self.application = application
    }
}