import UIKit
import UIKitTestable
import XCTest



public func awaitViewControllerEvent(
    _ expectedEvent: ViewControllerEvent,
    on testCase: XCTestCase,
    timeout: TimeInterval? = nil,
    _ callback: @escaping (UIViewController, ViewControllerEvent) -> Void
) {
    let expectation = testCase.expectation(description: "Awaiting \(expectedEvent)")

    let presenter = GlobalModalPresenter(wherePresentOn: UIWindow())
    let viewController = AwaitingViewController() { (viewController, actualEvent) in
        guard actualEvent == expectedEvent else { return }

        callback(viewController, actualEvent)

        expectation.fulfill()
    }

    presenter.present(viewController: viewController, animated: false)

    testCase.waitForExpectations(timeout: timeout ?? awaitingDefaultTimeout)
}



public func awaitViewDidLoad(
    on testCase: XCTestCase,
    timeout: TimeInterval? = nil,
    _ callback: @escaping (UIViewController) -> Void
) {
    awaitViewControllerEvent(.viewDidLoad, on: testCase, timeout: timeout) { (viewController, event) in
        callback(viewController)
    }
}



public enum ViewControllerEvent: Equatable {
    case `init`
    case viewDidLoad
    case viewWillAppear(animated: Bool)
    case viewDidAppear(animated: Bool)
    case viewWillDisappear(animated: Bool)
    case viewDidDisappear(animated: Bool)
    case viewWillLayoutSubviews
    case viewDidLayoutSubviews
    case didMove(parent: UIViewController?)
    case willMove(parent: UIViewController?)
    case didReceiveMemoryWarning
    case viewWillTransition(size: CGSize, coordinator: UIViewControllerTransitionCoordinator)
    case `deinit`


    public static func ==(lhs: ViewControllerEvent, rhs: ViewControllerEvent) -> Bool {
        switch (lhs, rhs) {
        case (.init, .init):
            return true
        case (.viewDidLoad, .viewDidLoad):
            return true
        case (.viewWillAppear(animated: let l), .viewWillAppear(animated: let r)):
            return l == r
        case (.viewDidAppear(animated: let l), .viewDidAppear(animated: let r)):
            return l == r
        case (.viewWillDisappear(animated: let l), .viewWillDisappear(animated: let r)):
            return l == r
        case (.viewDidDisappear(animated: let l), .viewDidDisappear(animated: let r)):
            return l == r
        case (.viewWillLayoutSubviews, .viewWillLayoutSubviews):
            return true
        case (.viewDidLayoutSubviews, .viewDidLayoutSubviews):
            return true
        case (.didMove(parent: let l), .didMove(parent: let r)):
            return l == r
        case (.willMove(parent: let l), .willMove(parent: let r)):
            return l == r
        case (.didReceiveMemoryWarning, .didReceiveMemoryWarning):
            return true
        case (.viewWillTransition(size: let ls, coordinator: let lc), .viewWillTransition(size: let rs, coordinator: let rc)):
            return ls == rs && lc.isEqual(rc)
        case (.deinit, .deinit):
            return true
        default:
            return false
        }
    }
}



public class AwaitingViewController: UIViewController {
    private let callback: (UIViewController, ViewControllerEvent) -> Void


    public init(willCall callback: @escaping (UIViewController, ViewControllerEvent) -> Void) {
        self.callback = callback

        super.init(nibName: nil, bundle: nil)

        self.callback(self, .init)
    }


    deinit {
        self.callback(self, .deinit)
    }


    public required init?(coder aDecoder: NSCoder) {
        return nil
    }


    public override func viewDidLoad() {
        super.viewDidLoad()
        self.callback(self, .viewDidLoad)
    }


    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.callback(self, .viewWillAppear(animated: animated))
    }


    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.callback(self, .viewDidAppear(animated: animated))
    }


    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.callback(self, .viewWillDisappear(animated: animated))
    }


    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.callback(self, .viewDidDisappear(animated: animated))
    }


    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.callback(self, .viewWillLayoutSubviews)
    }


    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.callback(self, .viewDidLayoutSubviews)
    }


    public override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        self.callback(self, .didMove(parent: parent))
    }


    public override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        self.callback(self, .willMove(parent: parent))
    }


    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.callback(self, .didReceiveMemoryWarning)
    }


    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.callback(self, .viewWillTransition(size: size, coordinator: coordinator))
    }
}
