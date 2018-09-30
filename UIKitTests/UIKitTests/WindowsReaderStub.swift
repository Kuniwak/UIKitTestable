import UIKit
import UIKitTestable



public class WindowsReaderStub: WindowsReaderProtocol {
    public var windows: [UIWindow]


    public init(alwaysReturn windows: [UIWindow]) {
        self.windows = windows
    }
}