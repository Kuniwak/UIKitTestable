import XCTest
import UIKitTests



class ArrayLongerThan1Tests: XCTestCase {
    func testJoined() {
    	typealias TestCase = (
			ArrayLongerThan1<String>,
            expected: String
    	)

    	let testCases: [UInt: TestCase] = [
    	    #line: (
                ArrayLongerThan1(["0"])!,
                expected: "0"
    	    ),
            #line: (
                ArrayLongerThan1(["0", "1"])!,
                expected: "0,1"
            ),
    	]

    	testCases.forEach { tuple in
    	    let (line, (array, expected: expected)) = tuple

            XCTAssertEqual(array.joined(separator: ","), expected, line: line)
    	}
    }
}


class ArrayLongerThan2Tests: XCTestCase {
    func testJoined() {
        typealias TestCase = (
            ArrayLongerThan2<String>,
            expected: String
        )

        let testCases: [UInt: TestCase] = [
            #line: (
                ArrayLongerThan2(["0", "1"])!,
                expected: "0,1"
            ),
            #line: (
                ArrayLongerThan2(["0", "1", "2"])!,
                expected: "0,1,2"
            ),
        ]

        testCases.forEach { tuple in
            let (line, (array, expected: expected)) = tuple

            XCTAssertEqual(array.joined(separator: ","), expected, line: line)
        }
    }
}