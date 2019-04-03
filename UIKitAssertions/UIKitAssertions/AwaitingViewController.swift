import UIKit
import UIKitTestable
import XCTest



public func awaitViewController(
    event expectedEvent: UIKitTestable.ViewControllerLifeCycleEvent,
    on testCase: XCTestCase,
    timeout: TimeInterval? = nil,
    shouldPrintEvents: Bool = false,
    _ callback: @escaping (UIKitTestable.ObservationViewController, UIKitTestable.ViewControllerLifeCycleEvent) -> Void
) {
    let expectation = testCase.expectation(description: "Awaiting \(expectedEvent)")

    let window = UIWindow()
    let presenter = GlobalModalPresenter(wherePresentOn: .weak(window))
    let viewController = UIKitTestable.ObservationViewController(shouldPrintEvents: shouldPrintEvents) { (viewController, actualEvent) in
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
    shouldPrintEvents: Bool = false,
    _ callback: @escaping (UIKitTestable.ObservationViewController) -> Void
) {
    awaitViewController(event: .viewDidLoad, on: testCase, timeout: timeout, shouldPrintEvents: shouldPrintEvents) { (viewController, event) in
        callback(viewController)
    }
}



public func awaitingViewController(
    willCall callback: @escaping (UIKitTestable.ObservationViewController, UIKitTestable.ViewControllerLifeCycleEvent) -> Void
) -> UIKitTestable.ObservationViewController {
    return .init(callback)
}
