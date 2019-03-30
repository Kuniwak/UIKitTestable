public func intersperse<T, CollectionT: Collection>(
    _ xs: CollectionT,
    _ y: T
) -> [T] where CollectionT.Element == T {
    guard let first = xs.first else {
        return []
    }

    var result = [first]

    xs.dropFirst().forEach { x in
        result.append(y)
        result.append(x)
    }

    return result
}