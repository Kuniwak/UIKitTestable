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


    func testRelaxed() {
        typealias TestCase = (
            ArrayLongerThan1<String>,
            expected: [String]
        )

        let testCases: [UInt: TestCase] = [
            #line: (
                ArrayLongerThan1(["a"])!,
                ["a"]
            ),
            #line: (
                ArrayLongerThan1(["a", "b"])!,
                ["a", "b"]
            ),
            #line: (
                ArrayLongerThan1(["a", "b", "c"])!,
                ["a", "b", "c"]
            ),
        ]

        testCases.forEach {
            let (line, (array, expected: expected)) = $0

            XCTAssertEqual(array.relaxed(), expected, line: line)
        }
    }


    func testSecondLast() {
        typealias TestCase = (
            ArrayLongerThan1<String>,
            expected: String?
        )

        let testCases: [UInt: TestCase] = [
            #line: (
                ArrayLongerThan1(["a"])!,
                expected: nil
            ),
            #line: (
                ArrayLongerThan1(["a", "b"])!,
                expected: "a"
            ),
            #line: (
                ArrayLongerThan1(["a", "b", "c"])!,
                expected: "b"
            ),
        ]
        testCases.forEach {
            let (line, (array, expected: expected)) = $0

            XCTAssertEqual(array.secondLast, expected, line: line)
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



    func testRelaxed() {
        typealias TestCase = (
            ArrayLongerThan2<String>,
            expected: ArrayLongerThan1<String>
        )

        let testCases: [UInt: TestCase] = [
            #line: (
                ArrayLongerThan2(["a", "b"])!,
                ArrayLongerThan1(["a", "b"])!
            ),
            #line: (
                ArrayLongerThan2(["a", "b", "c"])!,
                ArrayLongerThan1(["a", "b", "c"])!
            ),
            #line: (
                ArrayLongerThan2(["a", "b", "c", "d"])!,
                ArrayLongerThan1(["a", "b", "c", "d"])!
            ),
        ]

        testCases.forEach {
            let (line, (array, expected: expected)) = $0

            XCTAssertEqual(array.relaxed(), expected, line: line)
        }
    }


    func testSecondLast() {
        typealias TestCase = (
            ArrayLongerThan2<String>,
            expected: String
        )

        let testCases: [UInt: TestCase] = [
            #line: (
                ArrayLongerThan2(["a", "b"])!,
                expected: "a"
            ),
            #line: (
                ArrayLongerThan2(["a", "b", "c"])!,
                expected: "b"
            ),
            #line: (
                ArrayLongerThan2(["a", "b", "c", "d"])!,
                expected: "c"
            ),
        ]

        testCases.forEach {
            let (line, (array, expected: expected)) = $0

            XCTAssertEqual(array.secondLast, expected, line: line)
        }
    }
}