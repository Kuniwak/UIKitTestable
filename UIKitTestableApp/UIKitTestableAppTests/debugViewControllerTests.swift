import XCTest
@testable import UIKitTestable
import UIKitAssertions



class DebugViewControllerTests: XCTestCase {
    func testPrint() {
        let expectation = self.expectation(description: "Awaiting debugViewController presentations")

        awaitViewController(event: .viewDidAppear, on: self) { (viewController, _) in
            let spy = PrinterSpy()

            viewController.present(debugViewController(forWritingTo: spy), animated: false) {
                XCTAssertEqual(
                    spy.printed,
                    """
                    .didInit
                    .viewDidLoad
                    .viewWillAppear(animated: true)
                    .viewLayoutMarginsDidChange
                    .viewSafeAreaInsetsDidChange
                    .viewWillLayoutSubviews
                    .viewDidLayoutSubviews
                    .viewDidAppear(animated: true)
                    """
                )
                expectation.fulfill()
            }
        }
    }
}