import XCTest
import UIKit
import UIKitTestable
import UIKitAssertions



class AwaitingViewControllerTests: XCTestCase {
    func testAwaitViewDidLoad() {
        let expectation = self.expectation(description: "testAwaitViewDidLoad")

        awaitViewDidLoad(on: self) { viewController in
            XCTAssertEqual(viewController.history.last!, .viewDidLoad)
            expectation.fulfill()
        }
    }



    func testAwaitViewDidDisappear() {
        let expectation = self.expectation(description: "testAwaitViewDidDisappear")

        awaitViewDidLoad(on: self) { viewController in
            DispatchQueue.main.async {
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
        }
    }
}