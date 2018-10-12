import XCTest
import UIKitTests



class ObjectTraverserTests: XCTestCase {
    func testTraverse() {
        enum EnterOrLeave: Equatable, CustomStringConvertible {
            case onEnter(Reference.NoNormalizedPathComponent, TypeName)
            case onLeave(Reference.NoNormalizedPathComponent, TypeName)
            var description: String {
                switch self {
                case .onEnter(let component, let type):
                    return "onEnter(\(component), \(type.text)"
                case .onLeave(let component, let type):
                    return "onLeave(\(component), \(type.text)"
                }
            }
        }
        struct Zero {}
        struct One { let zero: Zero }
        struct Two { let one: One }
        class DirectCircular { var x: DirectCircular? }
        class IndirectCircular { var x: Intermediate? }
        struct Intermediate { let y: IndirectCircular }


        typealias TestCase = (
            Any,
            expected: [EnterOrLeave]
        )

        let testCases: [UInt: TestCase] = [
            #line: (
                Zero(),
                expected: []
            ),
            #line: (
                One(zero: Zero()),
                expected: [
                    .onEnter(.label("zero"), TypeName(text: "Zero")),
                    .onLeave(.label("zero"), TypeName(text: "Zero")),
                ]
            ),
            #line: (
                Two(one: One(zero: Zero())),
                expected: [
                    .onEnter(.label("one"), TypeName(text: "One")),
                    .onEnter(.label("zero"), TypeName(text: "Zero")),
                    .onLeave(.label("zero"), TypeName(text: "Zero")),
                    .onLeave(.label("one"), TypeName(text: "One")),
                ]
            ),
            #line: (
                {
                    let directCircular = DirectCircular()
                    directCircular.x = directCircular
                    return directCircular
                }(),
                expected: [
                    .onEnter(.label("x"), TypeName(text: "Optional<DirectCircular>")),
                    .onEnter(.label("some"), TypeName(text: "DirectCircular")),
                    .onLeave(.label("some"), TypeName(text: "DirectCircular")),
                    .onLeave(.label("x"), TypeName(text: "Optional<DirectCircular>")),
                ]
            ),
            #line: (
                {
                    let indirectCircular = IndirectCircular()
                    indirectCircular.x = Intermediate(y: indirectCircular)
                    return indirectCircular
                }(),
                expected: [
                    .onEnter(.label("x"), TypeName(text: "Optional<Intermediate>")),
                    .onEnter(.label("some"), TypeName(text: "Intermediate")),
                    .onEnter(.label("y"), TypeName(text: "IndirectCircular")),
                    .onLeave(.label("y"), TypeName(text: "IndirectCircular")),
                    .onLeave(.label("some"), TypeName(text: "Intermediate")),
                    .onLeave(.label("x"), TypeName(text: "Optional<Intermediate>")),
                ]
            ),
        ]
        testCases.forEach {
            let (line, (target, expected: expected)) = $0

            var actual = [EnterOrLeave]()

            traverseObject(
                target,
                onEnter: { actual.append(.onEnter($0, TypeName(of: $1))) },
                onLeave: { actual.append(.onLeave($0, TypeName(of: $1))) }
            )

            XCTAssertEqual(actual, expected, line: line)
        }
    }



}