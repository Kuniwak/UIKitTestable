import XCTest
import UIKit
import UIKitTestable


class DebugTests: XCTestCase {
    class ExampleViewController: UIViewController {}


    func testInfo() {
        let actual = info(of: ExampleViewController())

        XCTAssertNotNil(actual)
    }


    func testTypeName() {
        let actual = typeName(of: ExampleViewController())

        XCTAssertEqual("UIKitTestableTests.DebugTests.ExampleViewController", actual)
    }


    func testAddress() {
        let actual = address(of: ExampleViewController())

        XCTAssertNotNil(actual)
    }


    func testLLDBHint() {
        let actual = lldbHint(for: ExampleViewController())

        XCTAssertNotNil(actual)
    }
}