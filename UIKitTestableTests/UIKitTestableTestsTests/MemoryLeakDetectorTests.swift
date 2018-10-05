import Foundation
import XCTest
import UIKitTests



class MemoryLeakDetectorTests: XCTestCase {
    func testReport() {
        let report = detectLeaks { () -> Node in
            let indirectNode = Node(linkedNodes: [])
            let node = Node(linkedNodes: [indirectNode])
            indirectNode.linkedNodes = [node]
            return node
        }

        print(report.description)
    }


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
                    leakedObjects: [],
                    circularPaths: []
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
                        MemoryLeakReport.LeakedObject(
                            objectDescription: "Node",
                            typeDescription: "Any",
                            location: Reference.Path.root
                        ),
                    ],
                    circularPaths: [
                        Reference.Path(components: [
                            .label("linkedNodes"),
                            .index(0),
                        ]),
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
                        MemoryLeakReport.LeakedObject(
                            objectDescription: "Node",
                            typeDescription: "Any",
                            location: Reference.Path.root
                        ),
                        MemoryLeakReport.LeakedObject(
                            objectDescription: "Node",
                            typeDescription: "Any",
                            location: Reference.Path(components: [
                                .label("linkedNodes"),
                                .index(0),
                            ])
                        ),
                    ],
                    circularPaths: [
                        Reference.Path(components: [
                            .label("linkedNodes"),
                            .index(0),
                            .label("linkedNodes"),
                            .index(0),
                        ]),
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
                        MemoryLeakReport.LeakedObject(
                            objectDescription: "Node",
                            typeDescription: "Any",
                            location: Reference.Path.root
                        ),
                        MemoryLeakReport.LeakedObject(
                            objectDescription: "Node",
                            typeDescription: "Any",
                            location: Reference.Path(components: [
                                .label("linkedNodes"),
                                .index(0),
                            ])
                        ),
                    ],
                    circularPaths: [
                        Reference.Path(components: [
                            .label("linkedNodes"),
                            .index(0),
                            .label("linkedNodes"),
                            .index(0),
                        ]),
                        Reference.Path(components: [
                            .label("linkedNodes"),
                            .index(0),
                            .label("linkedNodes"),
                            .index(1),
                        ]),
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
                        MemoryLeakReport.LeakedObject(
                            objectDescription: "LazyCircularNode",
                            typeDescription: "Any",
                            location: Reference.Path.root
                        ),
                        MemoryLeakReport.LeakedObject(
                            objectDescription: "Indirect",
                            typeDescription: "Any",
                            location: Reference.Path(components: [
                                .label("indirect"),
                            ])
                        ),
                    ],
                    circularPaths: [
                        Reference.Path(components: [
                            .label("indirect"),
                            .label("value"),
                        ]),
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
        let missingLeakedObjects = a.leakedObjects.subtracting(b.leakedObjects)
            .map { $0.description }

        let missingCircularPaths = a.circularPaths.subtracting(b.circularPaths)
            .map { $0.description }

        let extraLeakedObjects = b.leakedObjects.subtracting(a.leakedObjects)
            .map { $0.description }

        let extraCircularPaths = b.circularPaths.subtracting(a.circularPaths)
            .map { $0.description }

        return format(sections([
            (name: "Missing leaked objects", body: lines(missingLeakedObjects)),
            (name: "Extra leaked objects", body: lines(extraLeakedObjects)),
            (name: "Missing circular paths", body: lines(missingCircularPaths)),
            (name: "Extra circular paths", body: lines(extraCircularPaths)),
        ]))
    }
}