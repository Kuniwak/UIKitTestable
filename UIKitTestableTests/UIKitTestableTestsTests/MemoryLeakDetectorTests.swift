import Foundation
import XCTest
@testable import UIKitTests



class MemoryLeakDetectorTests: XCTestCase {
    func testMemoryLeak() {
    	typealias TestCase = (
            build: () -> Any,
            expectedPathLabelsLeaked: Set<[String?]>
    	)

    	let testCases: [UInt: TestCase] = [
    	    #line: ( // No circulars
                build: { () -> Node in
                    return Node(linkedNodes: [])
                },
                expectedPathLabelsLeaked: []
    	    ),
            #line: ( // Single direct circular
                build: { () -> Node in
                    let node = Node(linkedNodes: [])
                    node.linkedNodes = [node]
                    return node
                },
                expectedPathLabelsLeaked: [
                    ["linkedNodes", "0"],
                ]
            ),
            #line: ( // Single indirect circular
                build: { () -> Node in
                    let indirectNode = Node(linkedNodes: [])
                    let node = Node(linkedNodes: [indirectNode])
                    indirectNode.linkedNodes = [node]
                    return node
                },
                expectedPathLabelsLeaked: [
                    ["linkedNodes", "0", "linkedNodes", "0"],
                ]
            ),
            #line: ( // Both direct and indirect circulars
                build: { () -> Node in
                    let indirectNode = Node(linkedNodes: [])
                    let node = Node(linkedNodes: [indirectNode])
                    indirectNode.linkedNodes = [node, indirectNode]
                    return node
                },
                expectedPathLabelsLeaked: [
                    ["linkedNodes", "0", "linkedNodes", "0"],
                    ["linkedNodes", "0", "linkedNodes", "1"],
                ]
            ),
    	]

    	testCases.forEach { tuple in
    	    let (line, (build: build, expectedPathLabelsLeaked: expectedPathLabelsLeaked)) = tuple

            let leakedPaths = detectLeaks(by: build)
            let leakedPathLabels = Set(leakedPaths.map { $0.labels })

            XCTAssertEqual(
                leakedPathLabels, expectedPathLabelsLeaked,
                differenceLeakedPaths(between: expectedPathLabelsLeaked, and: leakedPathLabels),
                line: line
            )
    	}
    }



    private final class Node {
        var linkedNodes: [Node]


        init(linkedNodes: [Node]) {
            self.linkedNodes = linkedNodes
        }
    }



    private func differenceLeakedPaths(between a: Set<[String?]>, and b: Set<[String?]>) -> String {
        let linesA = a
            .map { "(\($0.map { $0 ?? "nil" } .joined(separator: " -> ")))" }
            .joined(separator: "\n")

        let linesB = b
            .map { "(\($0.map { $0 ?? "nil" } .joined(separator: " -> ")))" }
            .joined(separator: "\n")

        return [
            "",
            "Expected:",
            linesA,
            "",
            "Actual:",
            linesB,
        ].joined(separator: "\n")
    }
}