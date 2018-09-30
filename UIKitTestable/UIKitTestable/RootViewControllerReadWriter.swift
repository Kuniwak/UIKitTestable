import UIKit



public protocol RootViewControllerReadWriterProtocol: RootViewControllerReaderProtocol, RootViewControllerWriterProtocol {}



public class RootViewControllerReadWriter: RootViewControllerReadWriterProtocol {
    private let reader: RootViewControllerReaderProtocol
    private let writer: RootViewControllerWriterProtocol


    public var rootViewController: UIViewController? {
        return self.reader.rootViewController
    }


    public init(readingBy reader: RootViewControllerReaderProtocol, writingBy writer: RootViewControllerWriterProtocol) {
        self.reader = reader
        self.writer = writer
    }


    public convenience init(readingAndWriting window: UIWindow) {
        self.init(
            readingBy: RootViewControllerReader(whoHaveRootViewController: window),
            writingBy: RootViewControllerWriter(whoHaveViewController: window)
        )
    }


    public func alter(to rootViewController: UIViewController) {
        self.alter(to: rootViewController, completion: nil)
    }


    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        self.writer.alter(to: rootViewController, completion: completion)
    }
}