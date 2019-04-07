import UIKit
import UIKitTestable
import XCTest



/// Awaits the event on any view controller.
/// - Parameters:
///     - expectedEventName: The awaited event name.
///     - testCase: The XCTestCase instance where the function was called.
///     - callback: The callback that takes the generated view controller and the notified event.
/// - Remark: Do not forget to call [`XCTestCase.waitForExpectations`](https://developer.apple.com/documentation/xctest/xctestcase/1500748-waitforexpectations#).
public func awaitAnyViewController(
    event expectedEventName: UIKitTestable.ViewControllerEvent.Name,
    on testCase: XCTestCase,
    _ callback: @escaping (UIKitTestable.ObservationViewController, UIKitTestable.ViewControllerEvent) -> Void
) {
    let expectation = testCase.expectation(description: "Awaiting \(expectedEventName.rawValue)")

    let window = UIWindow()
    let presenter = WindowModalPresentDismisser(wherePresentOn: .weak(window))
    let viewController = UIKitTestable.ObservationViewController { (viewController, actualEvent) in
        guard actualEvent.name == expectedEventName else { return }

        callback(viewController, actualEvent)

        expectation.fulfill()
    }

    presenter.present(viewController: viewController, animated: false)
}



/// Awaits `viewDidAppear` on any view controller.
/// - Parameters:
///     - testCase: The XCTestCase instance where the function was called.
///     - callback: The callback that takes the generated view controller.
/// - Remark: Do not forget to call [`XCTestCase.waitForExpectations`](https://developer.apple.com/documentation/xctest/xctestcase/1500748-waitforexpectations#).
public func awaitAnyViewDidAppear(
    on testCase: XCTestCase,
    _ callback: @escaping (UIKitTestable.ObservationViewController) -> Void
) {
    awaitAnyViewController(event: .viewDidAppear, on: testCase) { (anyViewController, _) in
        callback(anyViewController)
    }
}



/// Awaits `viewDidAppear` on the specified view controller.
/// - Parameters:
///     - viewController: An UIViewController you need to present.
///     - testCase: A XCTestCase instance where the function was called.
///     - callback: A callback that takes the generated view controller.
/// - Remark: Do not forget to call [`XCTestCase.waitForExpectations`](https://developer.apple.com/documentation/xctest/xctestcase/1500748-waitforexpectations#).
/// - SeeAlso: The actual usage is in [`SpyViewControllerUsages`](https://kuniwak.github.io/UIKitTestable/UIKitTestableAppTests/Classes/SpyViewControllerUsages.html).
public func awaitViewDidAppear<ViewController: UIViewController>(
    _ viewController: ViewController,
    on testCase: XCTestCase,
    _ callback: @escaping (ViewController) -> Void
) {
    let expectation = testCase.expectation(description: "Awaiting to present \(info(of: viewController))")

    awaitAnyViewDidAppear(on: testCase) { anyViewController in
        anyViewController.present(viewController, animated: false) {
            callback(viewController)
            expectation.fulfill()
        }
    }
}
