import XCTest
import UIKit
import UIKitTestable
import UIKitAssertions



class AwaitingViewControllerTests: XCTestCase {
    func testAwaitAnyViewController() {
        let expectation = self.expectation(description: "testAwaitViewDidLoad")

        awaitAnyViewController(event: .viewDidLoad, on: self) { viewController, _ in
            XCTAssertEqual(viewController.history.last, .viewDidLoad)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 3.0)
    }


    func testAwaitViewDidAppear() {
        let expectation = self.expectation(description: "testAwaitViewDidAppear")
        let spy = spyViewController()

        awaitViewDidAppear(spy, on: self) { _ in
            XCTAssertEqual(spy.history.last?.name, .viewDidAppear)
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 3.0)
    }


    func testAwaitAnyViewDidDisappear() {
        let expectation = self.expectation(description: "testAwaitViewDidDisappear")

        awaitAnyViewDidAppear(on: self) { viewController in
            viewController.dismiss(animated: false) {
                XCTAssertEqual(
                    viewController.history.last!,
                    // XXX: Why true...?
                    // RELATED: https://stackoverflow.com/q/45861348/4078588
                    .viewDidDisappear(animated: true),
                    dumped(viewController.history)
                )
                expectation.fulfill()
            }
        }

        self.waitForExpectations(timeout: 3.0)
    }
}