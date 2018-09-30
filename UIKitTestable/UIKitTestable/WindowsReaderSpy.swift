import UIKit



public class WindowsReaderSpy: WindowsReaderProtocol {
    public enum CallArgs: Equatable {
        case windows
    }


    public private(set) var callArgs = [CallArgs]()
    public var delegate: WindowsReaderProtocol


    public init(delegating delegate: WindowsReaderProtocol = WindowsReaderStub(alwaysReturn: [])) {
        self.delegate = delegate
    }


    public var windows: [UIWindow] {
        self.callArgs.append(.windows)
        return self.delegate.windows
    }
}