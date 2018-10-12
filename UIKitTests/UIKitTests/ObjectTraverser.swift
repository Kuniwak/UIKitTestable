public func traverseObjectWithPath(
    _ target: Any,
    onEnter: ((Reference.NoNormalizedPathComponent, Any, [(component: Reference.NoNormalizedPathComponent, value: Any)]) -> Void)?,
    onLeave: ((Reference.NoNormalizedPathComponent, Any, [(component: Reference.NoNormalizedPathComponent, value: Any)]) -> Void)?
) {
    var currentPath: [(component: Reference.NoNormalizedPathComponent, value: Any)] = []

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



public func traverseObject(
    _ target: Any,
    onEnter: ((Reference.NoNormalizedPathComponent, Any) -> Void)?,
    onLeave: ((Reference.NoNormalizedPathComponent, Any) -> Void)?
) {
    var footprint = Set<Reference.ID>()

    traverseObjectRecursive(
        target,
        footprint: &footprint,
        onEnter: onEnter,
        onLeave: onLeave
    )
}



private func traverseObjectRecursive(
    _ target: Any,
    footprint: inout Set<Reference.ID>,
    onEnter: ((Reference.NoNormalizedPathComponent, Any) -> Void)?,
    onLeave: ((Reference.NoNormalizedPathComponent, Any) -> Void)?
) {
    // NOTE: Avoid infinite recursions caused by circular references.
    let id = Reference.ID(of: target)
    if !footprint.contains(id) {
        footprint.insert(id)

        let mirror = Mirror(reflecting: target)
        mirror.children.enumerated().forEach { indexAndChild in
            let (index, (label: label, value: value)) = indexAndChild

            let component = Reference.NoNormalizedPathComponent(
                isCollection: mirror.displayStyle == .collection,
                index: index,
                label: label
            )

            onEnter?(component, value)

            traverseObjectRecursive(
                value,
                footprint: &footprint,
                onEnter: onEnter,
                onLeave: onLeave
            )

            onLeave?(component, value)
        }
    }
}
