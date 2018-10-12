import XCTest
import UIKitTests



class ReferenceIDTests: XCTestCase {
    func testEquatable() {
    	typealias TestCase = (
			Reference.ID,
			Reference.ID,
			expected: Bool
    	)

    	let testCases: [UInt: TestCase] = [
    	    #line: (
				Reference.ID(of: 0),
				Reference.ID(of: 0),
                expected: false
    	    ),
			#line: {
				let object1 = NSObject()
                let object2 = NSObject()
				return (
					Reference.ID(of: object1),
					Reference.ID(of: object2),
					expected: false
				)
			}(),
			#line: {
				let object = NSObject()
				return (
					Reference.ID(of: object),
					Reference.ID(of: object),
					expected: true
				)
			}()
    	]

    	testCases.forEach { tuple in
    	    let (line, (a, b, expected: expected)) = tuple

			XCTAssertEqual(a == b, expected, line: line)
    	}
    }
}