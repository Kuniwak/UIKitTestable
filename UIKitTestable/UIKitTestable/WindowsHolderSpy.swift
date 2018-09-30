import UIKit



public class WindowsHolderSpy: WindowsHolderProtocol {
    public typealias CallArgs = ()

    public fileprivate(set) var callArgs = [CallArgs]()
    public var delegate: WindowsHolderProtocol


    public init(delegating delegate: WindowsHolderProtocol) {
        self.delegate = delegate
    }


    public var windows: [UIWindow] {
        self.callArgs.append(())
        return self.delegate.windows
    }
}