import UIKitTestable



public func detectLeaks<T>(by build: () -> T) -> MemoryLeakReport {
    let releasedWeakMap = autoreleasepool { () -> [Reference.ID: Reference] in
        return createWeakMap(from: build())
    }

    return MemoryLeakReport(references: releasedWeakMap.values)
}



public func detectLeaks<T>(by build: (@escaping (T) -> Void) -> Void, _ callback: @escaping (MemoryLeakReport) -> Void) {
    build { target in
        let releasedWeakMap = autoreleasepool { () -> [Reference.ID: Reference] in
            return createWeakMap(from: target)
        }

        callback(MemoryLeakReport(references: releasedWeakMap.values))
    }
}



public struct MemoryLeakReport: Hashable {
    public let leakedObjects: Set<LeakedObject>


    public init(leakedObjects: Set<LeakedObject>) {
        self.leakedObjects = leakedObjects
    }


    public init<Seq: Sequence>(references: Seq) where Seq.Element == Reference {
        let leakedObjects = Set(references.compactMap { LeakedObject(reference: $0) })
        self.init(leakedObjects: leakedObjects)
    }
}



extension MemoryLeakReport: PrettyPrintable {
    public var descriptionLines: [IndentedLine] {
        let leakedObjectsPart = sections(self.leakedObjects.map { $0.descriptionLines })

        return sections([
            (name: "Summary", body: lines([
                "Found \(self.leakedObjects.count) leaked objects",
            ])),
            (name: "Leaked objects", body: leakedObjectsPart),
        ])
    }
}



public struct LeakedObject: Hashable {
    public let objectDescription: String
    public let typeName: TypeName
    public let location: Reference.Path?
    public let circularPaths: Set<Reference.CircularPath>


    public init(
        objectDescription: String,
        typeName: TypeName,
        location: Reference.Path?,
        circularPaths: Set<Reference.CircularPath>
    ) {
        self.objectDescription = objectDescription
        self.typeName = typeName
        self.location = location
        self.circularPaths = circularPaths
    }


    public init?(reference: Reference) {
        guard !reference.isReleased else {
            return nil
        }

        self.init(
            objectDescription: reference.destinationObjectDescription,
            typeName: reference.destinationTypeName,
            location: Reference.Path(identifiablePath: reference.foundLocations.first),
            circularPaths: Set(reference.foundLocations.flatMap { identifiablePath in
                return Reference.CircularPath.from(
                    rootTypeName: reference.destinationTypeName,
                    identifiablePath: identifiablePath
                )
            })
        )
    }
}



extension LeakedObject: PrettyPrintable {
    public var descriptionLines: [IndentedLine] {
        return descriptionList([
            (label: "Description", description: self.objectDescription),
            (label: "Type", description: self.typeName.text),
            (label: "Location", description: self.location?.description ?? "(N/A)"),
            (label: "Circular Paths", description: "")
        ]) + indent(lines(self.circularPaths.map { $0.description }))
    }
}



internal func createWeakMap<T>(from target: T) -> [Reference.ID: Reference] {
    var result = [
        Reference.ID(of: target): Reference(
            target,
            foundLocations: ArrayLongerThan1<Reference.IdentifiablePath>(
                prefix: Reference.IdentifiablePath(root: target, componentAndValuePairs: []), []
            )
        )
    ]

    traverseObjectWithPath(
        target,
        onEnter: { (_, value, path) in
            let childReferenceID = Reference.ID(of: value)

            if let visitedReference = result[childReferenceID] {
                visitedReference.found(location: .init(
                    root: target,
                    componentAndValuePairs: path
                ))
            }
            else {
                result[childReferenceID] = Reference(
                    value,
                    foundLocations: ArrayLongerThan1(
                        prefix: .init(
                            root: target,
                            componentAndValuePairs: path
                        ),
                        []
                    )
                )
            }
        },
        onLeave: nil
    )

    return result
}
