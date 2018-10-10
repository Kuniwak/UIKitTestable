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

        let window = UIWindow()
        let modalPresenter = GlobalModalPresenter(wherePresentOn: .weak(window))
        modalPresenter.present(
            viewController: spyViewController,
            animated: false
        )

        _ = window

        self.waitForExpectations(timeout: 3)
    }



    func testDismiss() {
        // NOTE: CPS is a simple way instead of Promisified tests in this case,
        // because this test target (UIViewController#dismiss) is designed for CPS.
        let expectation = self.expectation(description: "Awaiting a call of viewDidDisappear")

        let window = UIWindow()
        let modalPresenter = GlobalModalPresenter(wherePresentOn: .weak(window))
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
                                _ = window
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
        let numberOfCreations: UInt = 100
        let thresholdOfAcceptableAliveWindows: UInt = 5
        let debugInfo = MemoryLeakTestDebugInfo()


        repeatSequentially(
            count: numberOfCreations,
            repeating: { (i, done) in
                let viewController = UIViewController()
                let window = CountedWindow()
                let modalPresenter = GlobalModalPresenter(wherePresentOn: .weak(window))

                debugInfo.log(index: i, window: window)

                modalPresenter.present(
                    viewController: viewController,
                    animated: false,
                    completion: {
                        modalPresenter.dismiss(
                            animated: false,
                            completion: {
                                DispatchQueue.main.async {
                                    _ = window
                                    done()
                                }
                            }
                        )
                    }
                )
            }
        ) {
            // XXX: Some UIWindows can be remained, but it is not a problem only if few remained.
            XCTAssertLessThan(
                CountedWindow.numberOfLiving, thresholdOfAcceptableAliveWindows,
                "A lot of UIWindow have been not released:" + debugInfo.debugDescription
            )

            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 10)
    }


    private class MemoryLeakTestDebugInfo {
        func log(index: UInt, window: UIWindow) {
            self.createdWindowLogs.append("\(index): \(window)")
        }


        var debugDescription: String {
            return [
                "",
                self.createdWindowInfo,
                "",
                self.aliveWindowInfo
            ].joined(separator: "\n")
        }


        private var createdWindowLogs = [String]()
        private var createdWindowInfo: String {
            var result = ["↑ Older UIWindow"]
            result.append(contentsOf: self.createdWindowLogs)
            result.append("↓ Newer UIWindow")
            return result.joined(separator: "\n")
        }


        private var aliveWindowInfo: String {
            return dumpString(UIApplication.shared.windows)
        }
    }
}
