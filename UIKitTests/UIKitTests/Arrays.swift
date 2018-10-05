internal func addPrefix<T>(to array: [T], prefix: T) -> [T] {
    var result = [prefix]
    result.append(contentsOf: array)
    return result
}



internal func addSuffix<T>(to array: [T], suffix: T) -> [T] {
    var result = array
    result.append(suffix)
    return result
}



internal func slideMap<T, R, SeqT: Sequence>(
    _ xs: SeqT,
    _ f: (T, T) -> R
) -> [R] where SeqT.Element == T {
    return zip(xs, xs.dropFirst())
        .map { f($0.0, $0.1) }
}


internal func scan<T, R, SeqT: Sequence>(
    _ xs: SeqT,
    _ initial: R,
    _ f: (R, T) -> R
) -> [R] where SeqT.Element == T {
    var intermediate = initial

    return xs.map { x in
        intermediate = f(intermediate, x)
        return intermediate
    }
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
