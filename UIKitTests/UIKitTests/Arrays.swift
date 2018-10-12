internal func scan<T, R, S: Sequence>(
    _ xs: S,
    initial: R,
    _ f: (R, T) -> R
) -> [R] where S.Element == T {
    var intermediate = initial

    return xs.map { x in
        intermediate = f(intermediate, x)
        return intermediate
    }
}



internal func slide<T, S: Sequence>(
    _ xs: S
) -> [(T, T)] where S.Element == T {
    return Array(zip(xs, xs.dropLast()))
}



internal func intersperse<T, CollectionT: Collection>(
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
