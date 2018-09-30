import UIKit
import XCTest
import UIKitTestable
import UIKitTests



class GlobalModalPresenterTests: XCTestCase {
    func testPresent() {
        // NOTE: CPS is a simple way instead of Promisified tests in this case,
        // because this test target (UIViewController#present) is designed for CPS.
        let expectation = self.expectation(description: "Awaiting a call of viewDidAppear")

        let spyViewController = AwaitingViewController() { (viewController, event) in
            guard event == .viewDidLoad else { return }
            expectation.fulfill()
        }

        let modalPresenter = GlobalModalPresenter(wherePresentOn: UIWindow())
        modalPresenter.present(
            viewController: spyViewController,
            animated: false
        )

        self.waitForExpectations(timeout: 3)
    }



    func testDismiss() {
        // NOTE: CPS is a simple way instead of Promisified tests in this case,
        // because this test target (UIViewController#dismiss) is designed for CPS.
        let expectation = self.expectation(description: "Awaiting a call of viewDidDisappear")

        let modalPresenter = GlobalModalPresenter(wherePresentOn: UIWindow())
        modalPresenter.present(
            viewController: UIViewController(),
            animated: false,
            completion: {
                DispatchQueue.main.async {
                    modalPresenter.dismiss(
                        animated: false,
                        completion: {
                            DispatchQueue.main.async {
                                _ = modalPresenter
                                expectation.fulfill()
                            }
                        }
                    )
                }
            }
        )

        self.waitForExpectations(timeout: 1)
    }


    func testNoMemoryLeaks() {
        // NOTE: CPS is a simple way instead of Promisified tests in this case,
        // because this test target (UIViewController#dismiss) is designed for CPS.
        let expectation = self.expectation(description: "Awaiting a call of viewDidDisappear")

        let viewController = UIViewController()

        let modalPresenter = GlobalModalPresenter(wherePresentOn: CountedWindow())
        modalPresenter.present(
            viewController: viewController,
            animated: false,
            completion: {
                DispatchQueue.main.async {
                    modalPresenter.dismiss(
                        animated: false,
                        completion: {
                            XCTAssertEqual(CountedWindow.numberOfLiving, 1, "UIWindow was not released")
                            _ = modalPresenter
                            expectation.fulfill()
                        }
                    )
                }
            }
        )

        self.waitForExpectations(timeout: 3)
    }
}
