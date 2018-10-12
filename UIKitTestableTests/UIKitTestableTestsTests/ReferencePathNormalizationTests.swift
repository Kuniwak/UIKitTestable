import XCTest
import UIKitTests



class ReferencePathNormalizationTests: XCTestCase {
    func testNormalize() {
        typealias TestCase = (
            input: [Reference.NoNormalizedPathComponent],
            expected: [Reference.PathComponent]
        )

        let testCases: [UInt: TestCase] = [
            #line: (
                input: [],
                expected: []
            ),
            #line: (
                input: [
                    .noLabel,
                ],
                expected: [
                    .noLabel,
                ]
            ),
            #line: (
                input: [
                    .label("label"),
                ],
                expected: [
                    .label("label"),
                ]
            ),
            #line: (
                input: [
                    .index(0),
                ],
                expected: [
                    .index(0),
                ]
            ),
            #line: (
                input: [
                    .label("label"),
                    .index(1)
                ],
                expected: [
                    .label("label"),
                    .index(1)
                ]
            ),
            #line: (
                input: [
                    .label("notLazy"),
                    .label("some")
                ],
                expected: [
                    .label("notLazy"),
                    .label("some")
                ]
            ),
            #line: (
                input: [
                    .label("some"),
                    .label("some"),
                ],
                expected: [
                    .label("some"),
                    .label("some"),
                ]
            ),


            // IMPORTANT CASES:
            #line: (
                input: [
                    .label("fake.storage"),
                    .label("some"),
                ],
                expected: [
                    .label("fake"),
                ]
            ),
            #line: (
                input: [
                    .label("label"),
                    .label("fake.storage"),
                    .label("some"),
                ],
                expected: [
                    .label("label"),
                    .label("fake"),
                ]
            ),
            #line: (
                input: [
                    .label("fake.storage"),
                    .label("some"),
                    .label("label"),
                ],
                expected: [
                    .label("fake"),
                    .label("label"),
                ]
            ),
        ]

        testCases.forEach { tuple in
            let (line, (input: input, expected: expected)) = tuple

            let actual = Reference.PathNormalization.normalize(input)

            XCTAssertEqual(
                actual, expected,
                difference(between: expected, and: actual),
                line: line
            )
        }
    }


    func testHint() {
        typealias TestCase = (
            input: Reference.NoNormalizedPathComponent,
            expected: Reference.PathNormalization.Hint
        )

        let testCases: [UInt: TestCase] = [
            #line: (
                input: .noLabel,
                expected: .none(.noLabel)
            ),
            #line: (
                input: .index(0),
                expected: .none(.index(0))
            ),
            #line: (
                input: .label("label"),
                expected: .none(.label("label"))
            ),
            #line: (
                input: .label("label.storage"),
                expected: .hasLazyStorageSuffix(label: "label.storage")
            ),
            #line: (
                input: .label("some"),
                expected: .isOptionalSome
            ),
            #line: (
                input: .label("some.storage"),
                expected: .hasLazyStorageSuffix(label: "some.storage")
            ),
        ]

        testCases.forEach {
            let (line, (input: input, expected: expected)) = $0

            let actual = Reference.PathNormalization.Hint(input)

            XCTAssertEqual(actual, expected, line: line)
        }
    }


    private func difference(between a: [Reference.PathComponent], and b: [Reference.PathComponent]) -> String {
        return format(verticalPadding(sections([
            (name: "Expected", body: lines(a.map { $0.description })),
            (name: "Actual", body: lines(b.map { $0.description })),
        ])))
    }
}