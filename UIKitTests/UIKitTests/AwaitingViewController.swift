import UIKit
import UIKitTestable
import XCTest



public func awaitViewControllerEvent(
    _ expectedEvent: ViewControllerLifeCycleEvent,
    on testCase: XCTestCase,
    timeout: TimeInterval? = nil,
    _ callback: @escaping (UIViewController, ViewControllerLifeCycleEvent) -> Void
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



public class AwaitingViewController: ViewControllerLifeCycleObserver {
    private let callback: (UIViewController, ViewControllerLifeCycleEvent) -> Void


    public init(willCall callback: @escaping (UIViewController, ViewControllerLifeCycleEvent) -> Void) {
        self.callback = callback
        super.init()
    }


    public required init?(coder aDecoder: NSCoder) {
        return nil
    }


    public override func handle(lifeCycleEvent: ViewControllerLifeCycleEvent) {
        self.callback(self, lifeCycleEvent)
    }
}
