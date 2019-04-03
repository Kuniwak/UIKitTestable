import UIKit



public protocol RootViewControllerReadWriterProtocol: RootViewControllerReaderProtocol, RootViewControllerWriterProtocol {}



extension RootViewControllerReadWriterProtocol {
    public static func stub(
        willReturn initialResult: WeakOrUnownedOrStrong<UIViewController> = .empty()
    ) -> RootViewControllerReadWriterStub {
        return RootViewControllerReadWriterStub(willReturn: initialResult)
    }


    public static func syncStub(
        willReturn initialResult: WeakOrUnownedOrStrong<UIViewController> = .empty()
    ) -> RootViewControllerReadWriterSyncStub {
        return RootViewControllerReadWriterSyncStub(willReturn: initialResult)
    }


    public static func asyncStub(
        willReturn initialResult: WeakOrUnownedOrStrong<UIViewController> = .empty()
    ) -> RootViewControllerReadWriterAsyncStub {
        return RootViewControllerReadWriterAsyncStub(willReturn: initialResult)
    }


    public static func neverStub(
        willReturn initialResult: WeakOrUnownedOrStrong<UIViewController> = .empty()
    ) -> RootViewControllerReadWriterNeverStub {
        return RootViewControllerReadWriterNeverStub(willReturn: initialResult)
    }


    public static func spy(
        inheriting inherited: RootViewControllerReadWriterProtocol = RootViewControllerReadWriterSyncStub()
    ) -> RootViewControllerReadWriterSpy {
        return RootViewControllerReadWriterSpy(inheriting: inherited)
    }
}



public final class WindowRootViewControllerReadWriter: RootViewControllerReadWriterProtocol {
    private let reader: RootViewControllerReaderProtocol
    private let writer: RootViewControllerWriterProtocol


    public var rootViewController: UIViewController? {
        return self.reader.rootViewController
    }


    public init(readingBy reader: RootViewControllerReaderProtocol, writingBy writer: RootViewControllerWriterProtocol) {
        self.reader = reader
        self.writer = writer
    }


    public convenience init(readingAndWriting window: WeakOrUnowned<UIWindow>) {
        self.init(
            readingBy: WindowRootViewControllerReader(whoHaveRootViewController: window),
            writingBy: WindowRootViewControllerWriter(whoHaveViewController: window)
        )
    }


    public func alter(to rootViewController: UIViewController) {
        self.alter(to: rootViewController, completion: nil)
    }


    public func alter(to rootViewController: UIViewController, completion: (() -> Void)?) {
        self.writer.alter(to: rootViewController, completion: completion)
    }
}