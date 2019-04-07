import XCTest
import UIKitTestable
import UIKitAssertions


class SpyViewControllerUsages: XCTestCase {
    func testUsage() {
        let expectation = self.expectation(description: "Awaiting to present a spy view controller")

        awaitAnyViewDidAppear(on: self) { bedViewController in
            let spy = spyViewController()

            bedViewController.present(spy, animated: false) {
                XCTAssertEqual(spy.history.last?.name, .viewDidAppear)
                expectation.fulfill()
            }
        }

        self.waitForExpectations(timeout: 3.0)
    }
}



