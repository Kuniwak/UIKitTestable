import UIKit



public protocol KeyWindowReaderProtocol {
    var keyWindow: UIWindow? { get }
}



public class KeyWindowReader: KeyWindowReaderProtocol {
    private let application: UIApplication


    public var keyWindow: UIWindow? {
        return self.application.keyWindow
    }


    public init(whoHaveKeyWindow application: UIApplication) {
        self.application = application
    }
}