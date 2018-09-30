import UIKit
import XCTest
import UIKitTestable



class GlobalModalPresenterTests: XCTestCase {
    func testPresent() {
        let spyViewController = SpyViewController()
        let modalPresenter = GlobalModalPresenter(wherePresentOn: UIWindow())

        // NOTE: CPS is a simple way instead of Promisified tests in this case,
        // because this test target (UIViewController#present) is designed for CPS.
        let expectation = self.expectation(description: "Awaiting a call of viewDidAppear")

        // XXX: Wait a few msecs to prevent the following error.
        // > failed: caught "NSInternalInconsistencyException", "props must have a valid clientID"
        Timer.scheduledTimer(
            withTimeInterval: 0.5,
            repeats: false,
            block: { _ in
                modalPresenter.present(
                    viewController: spyViewController,
                    animated: false,
                    completion: {
                        XCTAssertEqual(
                            spyViewController.callArgs,
                            [
                                .viewDidAppear(animated: true),
                            ]
                        )
                        expectation.fulfill()
                    }
                )
            }
        )

        self.waitForExpectations(timeout: 1)
    }



    func testDismiss() {
        let spyViewController = SpyViewController()
        let modalPresenter = GlobalModalPresenter(wherePresentOn: UIWindow())

        // NOTE: CPS is a simple way instead of Promisified tests in this case,
        // because this test target (UIViewController#dismiss) is designed for CPS.
        let expectation = self.expectation(description: "Awaiting a call of viewDidDisappear")

        // XXX: Wait a few msecs to prevent the following error.
        // > failed: caught "NSInternalInconsistencyException", "props must have a valid clientID"
        Timer.scheduledTimer(
            withTimeInterval: 0.5,
            repeats: false,
            block: { _ in
                modalPresenter.present(
                    viewController: spyViewController,
                    animated: false,
                    completion: {
                        modalPresenter.dismiss(
                            animated: false,
                            completion: {
                                XCTAssertEqual(
                                    spyViewController.callArgs,
                                    [
                                        .viewDidAppear(animated: true),
                                        .viewDidDisappear(animated: true),
                                    ]
                                )
                                expectation.fulfill()
                            }
                        )
                    }
                )
            }
        )

        self.waitForExpectations(timeout: 1)
    }
}
