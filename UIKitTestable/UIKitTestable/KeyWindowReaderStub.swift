import UIKit



public class KeyWindowReaderStub: KeyWindowReaderProtocol {
    public var keyWindow: UIWindow?


    public init(willReturn keyWindow: UIWindow?) {
        self.keyWindow = keyWindow
    }
}