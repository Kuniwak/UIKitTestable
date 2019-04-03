import UIKit



public final class WindowsReaderSpy: WindowsReaderProtocol {
    public enum CallArgs: Equatable {
        case windows
    }


    public private(set) var callArgs = [CallArgs]()
    public var inherited: WindowsReaderProtocol


    public init(inheriting inherited: WindowsReaderProtocol = WindowsReaderStub()) {
        self.inherited = inherited
    }


    public var windows: [UIWindow] {
        self.callArgs.append(.windows)
        return self.inherited.windows
    }
}
