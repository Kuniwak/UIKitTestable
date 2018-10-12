import UIKitTestable



public class Reference {
    private let value: WeakOrNotReferenceType
    private let id: ID

    public let destinationTypeName: TypeName
    public let destinationObjectDescription: String
    public var foundLocations: ArrayLongerThan1<IdentifiablePath>


    public init(
        value: WeakOrNotReferenceType,
        id: ID,
        typeName: TypeName,
        description: String,
        foundLocations: ArrayLongerThan1<IdentifiablePath>
    ) {
        self.value = value
        self.id = id
        self.destinationTypeName = typeName
        self.destinationObjectDescription = description
        self.foundLocations = foundLocations
    }


    public convenience init(_ target: Any, foundLocations: ArrayLongerThan1<IdentifiablePath>) {
        self.init(
            value: WeakOrNotReferenceType(target),
            id: ID(of: target),
            typeName: TypeName(of: target),
            description: "\(target)",
            foundLocations: foundLocations
        )
    }


    public var isReleased: Bool {
        guard let weak = self.value.weak else {
            return true
        }

        return weak.isReleased
    }


    public func found(location: IdentifiablePath) {
        self.foundLocations.append(location)
    }



    public struct Path: Hashable {
        public let components: [PathComponent]


        public var count: Int {
            return self.components.count
        }


        public var description: String {
            return "(root)" + self.components
                .map { $0.description }
                .joined(separator: "")
        }


        public init(components: [PathComponent]) {
            self.components = components
        }


        public init(identifiablePath: IdentifiablePath) {
            let hints = identifiablePath
                .idComponents
                .map { PathNormalization.Hint($0.noNormalizedComponent) }

            self.init(components: PathNormalization.normalize(hints: hints))
        }


        public static let root = Path(components: [])
    }



    public enum PathComponent: Hashable {
        case label(String)
        case index(Int)
        case noLabel


        public var description: String {
            switch self {
            case .label(let label):
                return ".\(label)"
            case .index(let index):
                return "[\(index)]"
            case .noLabel:
                return "[unknown accessor]"
            }
        }
    }



    // NOTE: Mirror.Child for values stored on lazy var become the following unreadable value:
    //       (label: propertyName + ".storage", value: Optional.some(value))
    public enum PathNormalization {
        public static let lazyStorageLabelSuffix = ".storage"
        public static let optionalSomeLabel = "some"


        public static func normalize(
            _ noNormalizedComponents: [NoNormalizedPathComponent]
        ) -> [PathComponent] {
            return self.normalize(hints: noNormalizedComponents.map { Hint($0) })
        }


        public static func normalize(
            _ noNormalizedComponents: ArrayLongerThan1<NoNormalizedPathComponent>
        ) -> ArrayLongerThan1<PathComponent> {
            return self.normalize(hints: noNormalizedComponents.map { Hint($0) })
        }


        public static func normalize(
            _ noNormalizedComponents: ArrayLongerThan2<NoNormalizedPathComponent>
        ) -> ArrayLongerThan1<PathComponent> {
            return self.normalize(hints: noNormalizedComponents.map { Hint($0) })
        }


        public static func normalize(
            hints: [Hint]
        ) -> [PathComponent] {
            guard let noEmptyHints = ArrayLongerThan1<Hint>(hints) else {
                return []
            }

            return self.normalize(hints: noEmptyHints).relaxed()
        }


        public static func normalize(
            hints: ArrayLongerThan1<Hint>
        ) -> ArrayLongerThan1<PathComponent> {
            guard let noEmptyHints = ArrayLongerThan2<Hint>(hints) else {
                return ArrayLongerThan1(prefix: self.normalize(initialHint: hints.first, nextHintIfExists: nil), [])
            }

            return self.normalize(hints: noEmptyHints)
        }
        
        
        public static func normalize(
            hints: ArrayLongerThan2<Hint>
        ) -> ArrayLongerThan1<PathComponent> {
            let prefix = self.contextDependedNormalize(currentHint: hints.prefix, nextHintIfExists: hints.rest.prefix)
            var suffixed = hints.map(Optional<Hint>.some)
            suffixed.append(nil)

            // NOTE: Create a pair that represent a bidirectional contexts.
            //       (prev, current, nextIfExists)
            //       [0, 1] -> [(0, 1, nil)]
            //       [0, 1, 2] -> [(0, 1, 2), (1, 2, nil)]
            let intermediates = zip(hints.relaxed().relaxed(), hints.dropFirst().relaxed(), suffixed.dropFirst().dropFirst())
                .compactMap { slided -> PathComponent? in
                    let (previousHint, currentHint, nextHintIfExists) = slided
                    return self.normalize(
                        previousHint: previousHint,
                        currentHint: currentHint,
                        nextHintIfExists: nextHintIfExists
                    )
                }

            return .init(prefix: prefix, intermediates)
        }


        public static func normalize(initialHint: Hint, nextHintIfExists: Hint?) -> PathComponent {
            return self.contextDependedNormalize(currentHint: initialHint, nextHintIfExists: nextHintIfExists)
        }


        public static func normalize(previousHint: Hint, currentHint: Hint, nextHintIfExists: Hint?) -> PathComponent? {
            switch (previousHint, currentHint, nextHintIfExists) {
            case (.hasLazyStorageSuffix, .isOptionalSome, _):
                return nil
            default:
                return self.contextDependedNormalize(currentHint: currentHint, nextHintIfExists: nextHintIfExists)
            }
        }


        // NOTE: This method can work properly only if the previous hint is not a lazy storage suffix.
        public static func contextDependedNormalize(currentHint: Hint, nextHintIfExists: Hint?) -> PathComponent {
            switch (currentHint, nextHintIfExists) {
            case (.hasLazyStorageSuffix(label: let label), .some(.isOptionalSome)):
                return .label(String(label.dropLast(self.lazyStorageLabelSuffix.count)))
            case (.hasLazyStorageSuffix(label: let label), _), (.none(.label(let label)), _):
                return .label(label)
            case (.none(.index(let index)), _):
                return .index(index)
            case (.none(.noLabel), _):
                return .noLabel
            case (.isOptionalSome, _):
                return .label(self.optionalSomeLabel)
            }
        }



        public enum Hint: Equatable {
            case none(NoNormalizedPathComponent)
            case hasLazyStorageSuffix(label: String)
            case isOptionalSome


            public init(_ component: NoNormalizedPathComponent) {
                switch component {
                case .label(let label):
                    if label.hasSuffix(PathNormalization.lazyStorageLabelSuffix) {
                        self = .hasLazyStorageSuffix(label: label)
                    }
                    else if (label == PathNormalization.optionalSomeLabel) {
                        self = .isOptionalSome
                    }
                    else {
                        self = .none(component)
                    }
                case .noLabel, .index:
                    self = .none(component)
                }
            }
        }
    }



    public struct CircularPath: Hashable {
        public let end: CircularPathEnd
        public let components: ArrayLongerThan1<PathComponent>


        public var description: String {
            let accessors = self.components
                .map { $0.description }
                .joined(separator: "")

            return "self\(accessors) === self"
        }


        public init(end: CircularPathEnd, components: ArrayLongerThan1<PathComponent>) {
            self.end = end
            self.components = components
        }


        public static func from(rootTypeName: TypeName, identifiablePath: IdentifiablePath) -> Set<CircularPath> {
            guard let idComponents = ArrayLongerThan1<IdentifiablePathComponent>(identifiablePath.idComponents) else {
                return []
            }

            let lastIdComponent = idComponents.last

            var result = Set<CircularPath>()
            let idComponentsCount = idComponents.count

            if lastIdComponent.isIdentified(by: identifiablePath.rootID) {
                result.insert(CircularPath(
                    end: .root(rootTypeName),
                    components: PathNormalization.normalize(idComponents.map { $0.noNormalizedComponent })
                ))
            }

            result.formUnion(
                Set(idComponents
                    .enumerated()
                    .filter { indexAndIdComponent in
                        let (_, idComponent) = indexAndIdComponent
                        return idComponent == lastIdComponent
                    }
                    .compactMap { indexAndIdComponent -> ArrayLongerThan1<IdentifiablePathComponent>? in
                        let (circularStartIndex, _) = indexAndIdComponent
                        let circularNextIndex = circularStartIndex + 1
                        let circularIdComponents = idComponents[circularNextIndex..<idComponentsCount]
                        return ArrayLongerThan1<IdentifiablePathComponent>(circularIdComponents)
                    }
                    .map { circularComponents -> CircularPath in
                        return CircularPath(
                            end: .intermediate(lastIdComponent.typeName),
                            components: PathNormalization.normalize(circularComponents.map { $0.noNormalizedComponent })
                        )
                    }
                )
            )

            return result
        }
    }



    public enum CircularPathEnd: Hashable {
        case root(TypeName)
        case intermediate(TypeName)
    }



    public struct IdentifiablePath: Hashable {
        public let rootID: ID
        public let idComponents: [IdentifiablePathComponent]


        public var isRoot: Bool {
            return self.idComponents.isEmpty
        }


        public init(rootID: ID, idComponents: [IdentifiablePathComponent]) {
            self.rootID = rootID
            self.idComponents = idComponents
        }


        public init<Pairs: Sequence>(
            root: Any, componentAndValuePairs: Pairs
        ) where Pairs.Element == (component: Reference.NoNormalizedPathComponent, value: Any) {
            self.init(
                rootID: ID(of: root),
                idComponents: componentAndValuePairs.map { pair in
                    let (component: component, value: value) = pair
                    return IdentifiablePathComponent(
                        id: ID(of: value),
                        typeName:  TypeName(of: value),
                        noNormalizedComponent: component
                    )
                }
            )
        }
    }


    public struct IdentifiablePathComponent: Hashable {
        public let noNormalizedComponent: NoNormalizedPathComponent
        public let typeName: TypeName
        private let id: ID


        public var hashValue: Int {
            return self.id.hashValue
        }


        public init(id: ID, typeName: TypeName, noNormalizedComponent: NoNormalizedPathComponent) {
            self.id = id
            self.typeName = typeName
            self.noNormalizedComponent = noNormalizedComponent
        }


        public func isIdentified(by id: ID) -> Bool {
            return self.id == id
        }


        public static func ==(lhs: IdentifiablePathComponent, rhs: IdentifiablePathComponent) -> Bool {
            return lhs.id == rhs.id
        }
    }



    public enum NoNormalizedPathComponent: Hashable {
        case label(String)
        case index(Int)
        case noLabel


        public init(
            isCollection: Bool,
            index: Int,
            label: String?
        ) {
            guard !isCollection else {
                self = .index(index)
                return
            }

            guard let label = label else {
                self = .noLabel
                return
            }

            self = .label(label)
        }
    }



    public enum ID {
        case anyReferenceType(name: TypeName, objectIdentifier: ObjectIdentifier)
        case anyValueType(name: TypeName)
        case unknown(name: TypeName)


        public init<T>(of target: T) {
            switch Mirror(reflecting: target).displayStyle {
            case .some(.class):
                let objectIdentifier = ObjectIdentifier(target as AnyObject)
                self = .anyReferenceType(
                    name: TypeName(of: target),
                    objectIdentifier: objectIdentifier
                )

            case .some(.tuple), .some(.struct), .some(.collection), .some(.dictionary),
                 .some(.enum), .some(.optional), .some(.set):
                self = .anyValueType(name: TypeName(of: target))

            case .none:
                self = .unknown(name: TypeName(of: target))
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



extension Reference.Path: Comparable {
    public static func <(lhs: Reference.Path, rhs: Reference.Path) -> Bool {
        return lhs.count < rhs.count
    }
}



extension Reference.ID: Equatable {
    public static func ==(lhs: Reference.ID, rhs: Reference.ID) -> Bool {
        switch (lhs, rhs) {
        case (.anyReferenceType(name: _, objectIdentifier: let l), .anyReferenceType(name: _, objectIdentifier: let r)):
            return l == r

        default:
            // NOTE: Any values should not be identical.
            return false
        }
    }
}



extension Reference.ID: Hashable {
    public var hashValue: Int {
        switch self {
        case .anyReferenceType(name: _, objectIdentifier: let objectIdentifier):
            return objectIdentifier.hashValue

        case .anyValueType:
            // NOTE: Any values should not be identical.
            return 0
            
        case .unknown:
            return 1
        }
    }
}
