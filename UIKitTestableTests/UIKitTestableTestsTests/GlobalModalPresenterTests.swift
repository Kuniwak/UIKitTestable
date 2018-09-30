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
        let thresholdOfAcceptableAliveWindows: UInt = 5

        var createdWindowLogs: [String] = ["↑ Older UIWindow"]

        repeatAsync(
            count: 100,
            repeating: { (i, done) in
                let viewController = UIViewController()
                let window = CountedWindow()
                let modalPresenter = GlobalModalPresenter(wherePresentOn: window)
                createdWindowLogs.append("\(i): \(window)")

                modalPresenter.present(
                    viewController: viewController,
                    animated: false,
                    completion: {
                        modalPresenter.dismiss(
                            animated: false,
                            completion: {
                                DispatchQueue.main.async {
                                    done()
                                }
                            }
                        )
                    }
                )
            }
        ) {
            var livingWindowsInfo = ""
            dump(UIApplication.shared.windows, to: &livingWindowsInfo)
            createdWindowLogs.append("↓ Newer UIWindow")

            // XXX: Some UIWindows can be remained, but it is not a problem only if few remained.
            XCTAssertLessThan(
                CountedWindow.numberOfLiving, thresholdOfAcceptableAliveWindows,
                "A lot of UIWindow have been not released:\n\(livingWindowsInfo)\n\n\(createdWindowLogs.joined(separator: "\n"))"
            )

            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10)
    }
}


private func repeatAsync(count: UInt, repeating f: @escaping(UInt, @escaping () -> Void) -> Void, _ last: @escaping () -> Void) {
    let first = (0..<count).reduce(last) { (prev: @escaping () -> Void, i: UInt) -> () -> Void in
        return { f(i, prev) }
    }

    first()
}
