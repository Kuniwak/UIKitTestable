import UIKit
import UIKitTestable
import XCTest



public func awaitViewController(
    event expectedEventKey: UIKitTestable.ViewControllerEvent.CodingKeys,
    on testCase: XCTestCase,
    timeout: TimeInterval? = nil,
    _ callback: @escaping (UIKitTestable.ObservationViewController, UIKitTestable.ViewControllerEvent) -> Void
) {
    let expectation = testCase.expectation(description: "Awaiting \(expectedEventKey.rawValue)")

    let window = UIWindow()
    let presenter = GlobalModalPresenter(wherePresentOn: .weak(window))
    let viewController = UIKitTestable.ObservationViewController { (viewController, actualEvent) in
        guard actualEvent.key == expectedEventKey else { return }

        callback(viewController, actualEvent)

        expectation.fulfill()
    }

    presenter.present(viewController: viewController, animated: false)

    testCase.waitForExpectations(timeout: timeout ?? awaitingDefaultTimeout)
}



public func awaitViewDidLoad(
    on testCase: XCTestCase,
    timeout: TimeInterval? = nil,
    _ callback: @escaping (UIKitTestable.ObservationViewController) -> Void
) {
    awaitViewController(event: .viewDidLoad, on: testCase, timeout: timeout) { (viewController, _) in
        callback(viewController)
    }
}



public func awaitingViewController(
    willCall callback: @escaping (UIKitTestable.ObservationViewController, UIKitTestable.ViewControllerEvent) -> Void
) -> UIKitTestable.ObservationViewController {
    return .init(callback)
}
