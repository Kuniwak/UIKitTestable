import XCTest
import UIKitTestable



class SpyViewControllerTests: XCTestCase {
    func testHistory() {
        let viewController = spyViewController()

        viewController.viewDidLoad()

        XCTAssertEqual(viewController.history, [
            UIKitTestable.ViewControllerEvent.didInit,
            UIKitTestable.ViewControllerEvent.viewDidLoad,
        ])
    }
}