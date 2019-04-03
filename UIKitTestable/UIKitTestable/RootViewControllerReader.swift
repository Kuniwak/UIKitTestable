import UIKit



public protocol RootViewControllerReaderProtocol: AnyObject {
    var rootViewController: UIViewController? { get }
}



extension RootViewControllerReaderProtocol {
    public static func stub(
        willReturn viewController: WeakOrUnownedOrStrong<UIViewController> = .empty()
    ) -> RootViewControllerReaderStub {
        return RootViewControllerReaderStub(willReturn: viewController)
    }


    public static func spy(
        inheriting inherited: RootViewControllerReaderProtocol = RootViewControllerReaderStub()
    ) -> RootViewControllerReaderSpy {
        return RootViewControllerReaderSpy(inheriting: inherited)
    }
}



public final class WindowRootViewControllerReader: RootViewControllerReaderProtocol {
    private let window: WeakOrUnowned<UIWindow>


    public var rootViewController: UIViewController? {
        switch self.window {
        case .weakReference(let weak):
            return weak.value?.rootViewController

        case .unownedReference(let unowned):
            return unowned.value.rootViewController
        }
    }


    public init(whoHaveRootViewController window: WeakOrUnowned<UIWindow>) {
        self.window = window
    }
}
