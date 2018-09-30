import UIKit



public class WindowsHolderStub: WindowsHolderProtocol {
    public var windows: [UIWindow]


    public init(alwaysReturn windows: [UIWindow]) {
        self.windows = windows
    }
}