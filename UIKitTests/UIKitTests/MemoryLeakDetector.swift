import UIKitTestable



public struct MemoryLeakReport: Hashable {
    public let leakedObjects: Set<LeakedObject>
    public let circularPaths: Set<Reference.Path>


    public init(
        leakedObjects: Set<LeakedObject>,
        circularPaths: Set<Reference.Path>
    ) {
        self.leakedObjects = leakedObjects
        self.circularPaths = circularPaths
    }


    public static func from<Seq: Sequence>(
        references: Seq
    ) -> MemoryLeakReport where Seq.Element == Reference {
        let leakedObjects = Set(references.compactMap { MemoryLeakReport.LeakedObject.from(reference: $0) })
        let circularPaths = self.getCircularPaths(from: references)

        return MemoryLeakReport(
            leakedObjects: leakedObjects,
            circularPaths: circularPaths
        )
    }



    public static func getCircularPaths<Seq: Sequence>(
        from references: Seq
    ) -> Set<Reference.Path> where Seq.Element == Reference {
        let circularPaths = references
            .filter { reference in !reference.isReleased }
            .flatMap { reference -> [Reference.RawPath] in
                return reference.rawPaths
            }
            .filter { rawPath in rawPath.isCircularAtEnd }
            .map { rawPath in Reference.Path.from(rawPath: rawPath) }

        return Set(circularPaths)
    }



    public struct LeakedObject: Hashable {
        public let objectDescription: String
        public let typeDescription: String
        public let location: Reference.Path?


        public init(
            objectDescription: String,
            typeDescription: String,
            location: Reference.Path?
        ) {
            self.objectDescription = objectDescription
            self.typeDescription = typeDescription
            self.location = location
        }


        public static func from(reference: Reference) -> LeakedObject? {
            guard !reference.isReleased else {
                return nil
            }

            return LeakedObject(
                objectDescription: reference.objectDescription,
                typeDescription: reference.typeDescription,
                location: reference.rawPaths
                    .map { Reference.Path.from(rawPath: $0) }
                    .min { $0.count < $1.count }
            )
        }
    }
}



public func detectLeaks<T>(by build: () -> T) -> MemoryLeakReport {
    let releasedWeakMap = autoreleasepool { () -> [Reference.ID: Reference] in
        return createWeakMap(from: build())
    }

    return .from(references: releasedWeakMap.values)
}



public func detectLeaks<T>(by build: (@escaping (T) -> Void) -> Void, _ callback: @escaping (MemoryLeakReport) -> Void) {
    build { target in
        let releasedWeakMap = autoreleasepool { () -> [Reference.ID: Reference] in
            return createWeakMap(from: target)
        }

        callback(.from(references: releasedWeakMap.values))
    }
}



internal func createWeakMap<T>(from target: T) -> [Reference.ID: Reference] {
    var result: [Reference.ID: Reference] = [:]

    traverseObjectWithPath(
        target,
        onEnter: { (_, value, path) in
            let childReferenceID = Reference.ID.from(value)

            if let visitedReference = result[childReferenceID] {
                visitedReference.append(rawPath: .from(path))
            }
            else {
                result[childReferenceID] = Reference.from(value, rawPaths: [.from(path)])
            }
        },
        onLeave: nil
    )

    return result
}



internal func traverseObjectWithPath(
    _ target: Any,
    onEnter: ((Reference.PathComponent, Any, [(component: Reference.PathComponent, value: Any)]) -> Void)?,
    onLeave: ((Reference.PathComponent, Any, [(component: Reference.PathComponent, value: Any)]) -> Void)?
) {
    var currentPath: [(component: Reference.PathComponent, value: Any)] = []

    traverseObject(
        target,
        onEnter: { (component, value) in
            currentPath.append((component: component, value: value))
            onEnter?(component, value, currentPath)
        },
        onLeave: { (component, value) in
            onLeave?(component, value, currentPath)
            currentPath.removeLast()
        }
    )
}



internal func traverseObject(
    _ target: Any,
    onEnter: ((Reference.PathComponent, Any) -> Void)?,
    onLeave: ((Reference.PathComponent, Any) -> Void)?
) {
    var footprint = Set<Reference.ID>()

    traverseObjectRecursive(
        component: .noLabel,
        target,
        footprint: &footprint,
        onEnter: onEnter,
        onLeave: onLeave
    )
}



private func traverseObjectRecursive(
    component: Reference.PathComponent,
    _ target: Any,
    footprint: inout Set<Reference.ID>,
    onEnter: ((Reference.PathComponent, Any) -> Void)?,
    onLeave: ((Reference.PathComponent, Any) -> Void)?
) {
    onEnter?(component, target)

    // NOTE: Avoid infinite recursions caused by circular references.
    let id = Reference.ID.from(target)
    if !footprint.contains(id) {
        footprint.insert(id)

        let mirror = Mirror(reflecting: target)
        mirror.children.enumerated().forEach { indexAndChild in
            let (index, (label: label, value: value)) = indexAndChild

            traverseObjectRecursive(
                // NOTE: Use the index as the label instead of nil only if the target is a collection.
                component: .from(
                    isCollection: mirror.displayStyle == .collection,
                    index: index,
                    label: label
                ),
                value,
                footprint: &footprint,
                onEnter: onEnter,
                onLeave: onLeave
            )
        }
    }

    onLeave?(component, target)
}



public class Reference {
    private let value: WeakOrNotReference

    public let id: ID
    public let typeDescription: String
    public let objectDescription: String
    public var rawPaths: [RawPath]


    internal init(
        value: WeakOrNotReference,
        id: ID,
        typeName: String,
        description: String,
        rawPaths: [RawPath]
    ) {
        self.value = value
        self.id = id
        self.typeDescription = typeName
        self.objectDescription = description
        self.rawPaths = rawPaths
    }


    public var isReleased: Bool {
        guard let weak = self.value.weak else {
            return true
        }

        return weak.isReleased
    }


    public func append(rawPath: RawPath) {
        self.rawPaths.append(rawPath)
    }


    public static func from<T>(_ target: T, rawPaths: [RawPath]) -> Reference {
        return Reference(
            value: .from(target),
            id: .from(target),
            typeName: "\(type(of: target))",
            description: "\(target)",
            rawPaths: rawPaths
        )
    }



    public struct Path: Hashable {
        public let components: [PathComponent]


        public var count: Int {
            return self.components.count
        }


        public var description: String {
            guard self.count > 0 else {
                return "(root)"
            }

            return self.components.map { component in
                switch component {
                case .label(let label):
                    return ".\(label)"
                case .index(let index):
                    return "[\(index)]"
                case .noLabel:
                    return "[unknown accessor]"
                }
            }.joined(separator: "")
        }


        public init(components: [PathComponent]) {
            self.components = components
        }


        public static let root = Path(components: [])


        public static func from(rawPath: RawPath) -> Path {
            // Remove the root component to make clear.
            let rawComponents = rawPath.rawComponents.dropFirst()

            // XXX: Mirror.Child for values stored on lazy var become the following unreadable value:
            //      (label: propertyName + ".storage", value: Optional.some(value))
            let lazyVarMask = addSuffix(to: slideMap(rawComponents) { (rawComponent, nextRawComponent) -> Bool in
                return rawComponent.component.hasLazyVarSuffix && nextRawComponent.component.isOptionalLabel
            }, suffix: false)

            let componentHints = scan(lazyVarMask, PathComponentHint.normal) { (previous, isLazyVar) -> PathComponentHint in
                guard previous != .lazyVar else {
                    return .optionalAfterLazyVar
                }

                return isLazyVar ? .lazyVar : .normal
            }

            return Path(components: zip(rawComponents, componentHints)
                .flatMap { (pair) -> [PathComponent] in
                    let (rawComponent, componentHint) = pair
                    switch componentHint {
                    case .normal:
                        return [rawComponent.component]
                    case .lazyVar:
                        return [rawComponent.component.withoutLazyVarSuffix]
                    case .optionalAfterLazyVar:
                        return []
                    }
                })
        }
    }



    public enum PathComponent: Hashable {
        case label(String)
        case index(Int)
        case noLabel


        public var hasLazyVarSuffix: Bool {
            switch self {
            case .noLabel, .index:
                return false
            case .label(let label):
                return label.hasSuffix(".storage")
            }
        }


        public var isOptionalLabel: Bool {
            switch self {
            case .noLabel, .index:
                return false
            case .label(let label):
                return label == "some"
            }
        }


        public var withoutLazyVarSuffix: PathComponent {
            switch self {
            case .noLabel, .index:
                return self
            case .label(let label):
                let suffix = ".storage"
                guard label.hasSuffix(suffix) else {
                    return self
                }

                return .label(String(label.dropLast(suffix.count)))
            }
        }


        public static func from(
            isCollection: Bool,
            index: Int,
            label: String?
        ) -> PathComponent {
            if isCollection {
                return .index(index)
            }

            guard let label = label else {
                return .noLabel
            }

            return .label(label)
        }
    }



    internal enum PathComponentHint: Equatable {
        case normal
        case lazyVar
        case optionalAfterLazyVar
    }



    public struct RawPath: Hashable {
        public let rawComponents: [RawPathComponent]


        public var count: Int {
            return self.rawComponents.count
        }


        public var isCircularAtEnd: Bool {
            let ids = self.rawComponents.map { $0.id }

            guard let lastID = ids.last else {
                return false
            }

            let idsWithoutLast = ids.dropLast()
            return idsWithoutLast.contains(lastID)
        }


        public static func from<T>( _ path: [(component: Reference.PathComponent, value: T)]) -> RawPath {
            return RawPath(rawComponents: path.map { RawPathComponent(component: $0.component, id: .from($0.value)) })
        }
    }



    public struct RawPathComponent: Hashable {
        public let component: PathComponent
        public let id: ID
    }



    public enum ID {
        case anyReference(objectIdentifier: ObjectIdentifier)
        case anyValue
        case unknown


        public static func from<T>(_ target: T) -> ID {
            switch Mirror(reflecting: target).displayStyle {
            case .some(.class):
                let objectIdentifier = ObjectIdentifier(target as AnyObject)
                return .anyReference(objectIdentifier: objectIdentifier)
            case .some:
                return .anyValue
            case .none:
                return .unknown
            }
        }
    }
}



extension Reference: Hashable {
    public var hashValue: Int {
        return self.id.hashValue
    }


    public static func ==(lhs: Reference, rhs: Reference) -> Bool {
        return lhs.id == rhs.id
    }
}



extension Reference.ID: Hashable {
    public var hashValue: Int {
        switch self {
        case .anyReference(objectIdentifier: let objectIdentifier):
            return objectIdentifier.hashValue
        case .anyValue:
            return 0
        case .unknown:
            return 1
        }
    }


    public static func ==(lhs: Reference.ID, rhs: Reference.ID) -> Bool {
        switch (lhs, rhs) {
        case (.anyReference(objectIdentifier: let l), .anyReference(objectIdentifier: let r)):
            return l == r
        default:
            return false
        }
    }
}



extension MemoryLeakReport: PrettyPrintable {
    public var descriptionLines: [IndentedLine] {
        let leakedObjectsPart = sections(self.leakedObjects.map { $0.descriptionLines })
        let circularPathsPart = sections(self.circularPaths.map { [.content($0.description)] })

        return sections([
            (name: "Summary", body: lines([
                "Found \(self.leakedObjects.count) leak objects",
            ])),
            (name: "Leaked objects", body: leakedObjectsPart),
            (name: "Circular reference paths", body: circularPathsPart),
        ])
    }
}



extension MemoryLeakReport.LeakedObject: PrettyPrintable {
    public var descriptionLines: [IndentedLine] {
        return descriptionList([
            (label: "Description", description: self.objectDescription),
            (label: "Type", description: self.typeDescription),
            (label: "Location", description: self.location?.description ?? "(N/A)"),
        ])
    }
}
