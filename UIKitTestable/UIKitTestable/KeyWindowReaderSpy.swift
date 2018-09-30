import UIKit



class KeyWindowReadergSpy: KeyWindowReaderProtocol {
    public typealias CallArgs = ()


    public fileprivate(set) var callArgs = [CallArgs]()
    public var delegate: KeyWindowReaderProtocol


    public  var keyWindow: UIWindow? {
        self.callArgs.append(())

        return self.delegate.keyWindow
    }


    public init(delegating delegate: KeyWindowReaderProtocol = KeyWindowReaderStub(willReturn: nil)) {
        self.delegate = delegate
    }
}