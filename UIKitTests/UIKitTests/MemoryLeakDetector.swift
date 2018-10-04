import UIKitTestable



public func detectLeaks<T>(by build: () -> T) -> Set<Reference.Path> {
    let releasedWeakMap = autoreleasepool { () -> [Reference.ID: Reference] in
        return createWeakMap(from: build())
    }

    let leaked = releasedWeakMap.values
        .filter { (reference) in !reference.isReleased }
        .flatMap { (reference) -> [Reference.Path] in reference.paths }
        .filter { path in path.isCircularAtEnd }

    return Set(leaked)
}



public func detectLeaks<T>(by build: (@escaping (T) -> Void) -> Void, _ callback: @escaping (Set<Reference.Path>) -> Void) {
    build { target in
        let releasedWeakMap = autoreleasepool { () -> [Reference.ID: Reference] in
            return createWeakMap(from: target)
        }

        let leaked = releasedWeakMap
            .values
            .filter { reference in !reference.isReleased }
            .flatMap { (reference) -> [Reference.Path] in reference.paths }
            .filter { path in path.isCircularAtEnd }

        callback(Set(leaked))
    }
}



internal func createWeakMap<T>(from target: T) -> [Reference.ID: Reference] {
    var result: [Reference.ID: Reference] = [:]

    traverseObjectWithPath(
        target,
        onEnter: { (label, value, path) in
            let childReferenceID = Reference.ID.from(value)

            if let visitedReference = result[childReferenceID] {
                visitedReference.append(path: .from(path))
            }
            else {
                result[childReferenceID] = Reference.from(value, paths: [.from(path)])
            }
        },
        onLeave: nil
    )

    return result
}



internal func traverseObjectWithPath(
    _ target: Any,
    onEnter: ((String?, Any, [(label: String?, value: Any)]) -> Void)?,
    onLeave: ((String?, Any, [(label: String?, value: Any)]) -> Void)?
) {
    var currentPath: [(label: String?, value: Any)] = []

    traverseObject(
        target,
        onEnter: { (label, value) in
            currentPath.append((label: label, value: value))
            onEnter?(label, value, currentPath)
        },
        onLeave: { (label, value) in
            onLeave?(label, value, currentPath)
            currentPath.removeLast()
        }
    )
}



internal func traverseObject(
    _ target: Any,
    onEnter: ((String?, Any) -> Void)?,
    onLeave: ((String?, Any) -> Void)?
) {
    var footprint = Set<Reference.ID>()

    traverseObjectRecursive(
        label: nil,
        target,
        footprint: &footprint,
        onEnter: onEnter,
        onLeave: onLeave
    )
}



private func traverseObjectRecursive(
    label: String?,
    _ target: Any,
    footprint: inout Set<Reference.ID>,
    onEnter: ((String?, Any) -> Void)?,
    onLeave: ((String?,  Any) -> Void)?
) {
    onEnter?(label, target)

    // NOTE: Avoid infinite recursions caused by circular references.
    let id = Reference.ID.from(target)
    if !footprint.contains(id) {
        footprint.insert(id)

        let mirror = Mirror(reflecting: target)
        mirror.children.enumerated().forEach { indexAndChild in
            let (index, (label: label, value: value)) = indexAndChild

            traverseObjectRecursive(
                // NOTE: Use the index as the label instead of nil only if the target is a collection.
                label: mirror.displayStyle == .collection ? "\(index)" : label,
                value,
                footprint: &footprint,
                onEnter: onEnter,
                onLeave: onLeave
            )
        }
    }

    onLeave?(label, target)
}



public class Reference {
    private let value: WeakOrNotReference

    public let id: ID
    public let typeName: String
    public let description: String
    public var paths: [Path]


    internal init(value: WeakOrNotReference, id: ID, typeName: String, description: String, paths: [Path]) {
        self.value = value
        self.id = id
        self.typeName = typeName
        self.description = description
        self.paths = paths
    }


    public var isReleased: Bool {
        guard let weak = self.value.weak else {
            return true
        }

        return weak.isReleased
    }


    public func append(path: Path) {
        self.paths.append(path)
    }


    public static func from<T>(_ target: T, paths: [Path]) -> Reference {
        return Reference(
            value: .from(target),
            id: .from(target),
            typeName: "\(type(of: target))",
            description: "\(target)",
            paths: paths
        )
    }



    public struct Path: Hashable {
        public let componentsWithRoot: [Component]


        public var components: [Component] {
            return Array(self.componentsWithRoot.dropFirst())
        }


        public var labels: [String?] {
            return self.components.map { $0.label }
        }


        public var isCircularAtEnd: Bool {
            let ids = self.componentsWithRoot.map { $0.id }

            guard let lastID = ids.last else {
                return false
            }

            let idsWithoutLast = ids.dropLast()
            return idsWithoutLast.contains(lastID)
        }


        public static func from<T, Seq>(
            _ path: Seq
        ) -> Path where Seq: Sequence, Seq.Element == (label: String?, value: T) {
            return Path(componentsWithRoot: path.map { Component(label: $0.label, id: .from($0.value)) })
        }



        public struct Component: Hashable {
            public let label: String?
            public let id: ID
        }
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
