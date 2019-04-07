import UIKit



/// A wrapper class that encapsulate a getter and setter of rootViewController.
/// This class does not have variations for any stubs or spies because these variations
/// can be created using stubs and spies for each reader and writer.
/// - SeeAlso: `RootViewControllerReadWriterUsages`.
public final class RootViewControllerReadWriter {
    private var reader: RootViewControllerReaderProtocol
    private var writer: RootViewControllerWriterProtocol


    /// Delegates to the `reader` and returns the result.
    public var rootViewController: UIViewController? {
        return self.reader.rootViewController
    }


    /// Returns a newly initialized `RootViewControllerReadWriter` with the specified reader and writer.
    /// - Parameters:
    ///     - reader: A delegated reader.
    ///     - writer: A delegated writer.
    public init(readingBy reader: RootViewControllerReaderProtocol, writingBy writer: RootViewControllerWriterProtocol) {
        self.reader = reader
        self.writer = writer
    }


    /// Returns a newly initialized `RootViewControllerReadWriter` with the `UIWindow`.
    /// Using `WindowRootViewControllerReader` and `WindowRootViewControllerWriter` as the internal reader and writer.
    /// - Parameters:
    ///     - window: An UIWindow.
    public convenience init(readingAndWriting window: WeakOrUnowned<UIWindow>) {
        self.init(
            readingBy: WindowRootViewControllerReader(whoHaveRootViewController: window),
            writingBy: WindowRootViewControllerWriter(whoHaveViewController: window)
        )
    }


    /// Delegates to the `writer`.
    public func alter(to rootViewController: UIViewController) {
        self.alter(to: rootViewController, completion: nil)
    }


    /// Delegates to the `writer`.
    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        self.writer.alter(to: rootViewController, completion: completion)
    }
}