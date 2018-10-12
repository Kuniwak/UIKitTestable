import Foundation
import XCTest
import UIKitTests



class MemoryLeakDetectorTests: XCTestCase {
    func testMemoryLeak() {
    	typealias TestCase = (
            build: () -> Any,
            expected: MemoryLeakReport
    	)

    	let testCases: [UInt: TestCase] = [
    	    #line: ( // No circulars
                build: { () -> Node in
                    return Node(linkedNodes: [])
                },
                expected: MemoryLeakReport(
                    leakedObjects: []
                )
    	    ),
            #line: ( // Single direct circular
                build: { () -> Node in
                    let node = Node(linkedNodes: [])
                    node.linkedNodes = [node]
                    return node
                },
                expected: MemoryLeakReport(
                    leakedObjects: [
                        LeakedObject(
                            objectDescription: "Node",
                            typeName: TypeName(text: "Node"),
                            location: Reference.Path.root,
                            circularPaths: [
                                Reference.CircularPath(
                                    end: .root(TypeName(text: "Node")),
                                    components: ArrayLongerThan1<Reference.PathComponent>([
                                        .label("linkedNodes"),
                                        .index(0),
                                    ])!
                                ),
                            ]
                        ),
                    ]
                )
            ),
            #line: ( // Single indirect circular
                build: { () -> Node in
                    let indirectNode = Node(linkedNodes: [])
                    let node = Node(linkedNodes: [indirectNode])
                    indirectNode.linkedNodes = [node]
                    return node
                },
                expected: MemoryLeakReport(
                    leakedObjects: [
                        LeakedObject(
                            objectDescription: "Node",
                            typeName: TypeName(text: "Node"),
                            location: Reference.Path.root,
                            circularPaths: [
                                Reference.CircularPath(
                                    end: .root(TypeName(text: "Node")),
                                    components: ArrayLongerThan1([
                                        .label("linkedNodes"),
                                        .index(0),
                                        .label("linkedNodes"),
                                        .index(0),
                                    ])!
                                )
                            ]
                        ),
                        LeakedObject(
                            objectDescription: "Node",
                            typeName: TypeName(text: "Node"),
                            location: Reference.Path(components: [
                                .label("linkedNodes"),
                                .index(0),
                            ]),
                            circularPaths: []
                        ),
                    ]
                )
            ),
            #line: ( // Both direct and indirect circulars
                build: { () -> Node in
                    let indirectNode = Node(linkedNodes: [])
                    let node = Node(linkedNodes: [indirectNode])
                    indirectNode.linkedNodes = [node, indirectNode]
                    return node
                },
                expected: MemoryLeakReport(
                    leakedObjects: [
                        LeakedObject(
                            objectDescription: "Node",
                            typeName: TypeName(text: "Node"),
                            location: Reference.Path.root,
                            circularPaths: [
                                Reference.CircularPath(
                                    end: .root(TypeName(text: "Node")),
                                    components: ArrayLongerThan1([
                                        .label("linkedNodes"),
                                        .index(0),
                                        .label("linkedNodes"),
                                        .index(0),
                                    ])!
                                ),
                            ]
                        ),
                        LeakedObject(
                            objectDescription: "Node",
                            typeName: TypeName(text: "Node"),
                            location: Reference.Path(components: [
                                .label("linkedNodes"),
                                .index(0),
                            ]),
                            circularPaths: [
                                Reference.CircularPath(
                                    end: .intermediate(TypeName(text: "Node")),
                                    components: ArrayLongerThan1([
                                        .label("linkedNodes"),
                                        .index(1),
                                    ])!
                                ),
                            ]
                        ),
                    ]
                )
            ),
            #line: ( // Lazy
                build: { () -> LazyCircularNode in
                    let node = LazyCircularNode()
                    _ = node.indirect
                    return node
                },
                expected: MemoryLeakReport(
                    leakedObjects: [
                        LeakedObject(
                            objectDescription: "LazyCircularNode",
                            typeName: TypeName(text: "LazyCircularNode"),
                            location: Reference.Path.root,
                            circularPaths: [
                                Reference.CircularPath(
                                    end: .root(TypeName(text: "LazyCircularNode")),
                                    components: ArrayLongerThan1([
                                        .label("indirect"),
                                        .label("value"),
                                    ])!
                                ),
                            ]
                        ),
                        LeakedObject(
                            objectDescription: "Indirect",
                            typeName: TypeName(text: "Indirect"),
                            location: Reference.Path(components: [
                                .label("indirect"),
                            ]),
                            circularPaths: []
                        ),
                    ]
                )
            ),
    	]

    	testCases.forEach { tuple in
    	    let (line, (build: build, expected: expected)) = tuple

            let memoryLeakHints = detectLeaks(by: build)

            XCTAssertEqual(
                memoryLeakHints, expected,
                differenceMemoryLeakReport(between: expected, and: memoryLeakHints),
                line: line
            )
    	}
    }



    private final class Node: CustomStringConvertible {
        var linkedNodes: [Node]


        init(linkedNodes: [Node]) {
            self.linkedNodes = linkedNodes
        }


        var description: String {
            return "Node"
        }
    }



    private final class LazyCircularNode: CustomStringConvertible {
        lazy var indirect: Indirect = Indirect(value: self)


        final class Indirect: CustomStringConvertible {
            let value: LazyCircularNode


            init(value: LazyCircularNode) {
                self.value = value
            }


            var description: String {
                return "Indirect"
            }
        }


        var description: String {
            return "LazyCircularNode"
        }
    }



    private func differenceMemoryLeakReport(between a: MemoryLeakReport, and b: MemoryLeakReport) -> String {
        let missingLeakedObjects = sections(a.leakedObjects.subtracting(b.leakedObjects)
            .map { $0.descriptionLines })

        let extraLeakedObjects = sections(b.leakedObjects.subtracting(a.leakedObjects)
            .map { $0.descriptionLines })

        return format(verticalPadding(sections([
            (name: "Missing leaked objects", body: missingLeakedObjects),
            (name: "Extra leaked objects", body: extraLeakedObjects),
        ])))
    }
}