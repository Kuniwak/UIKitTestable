internal func repeatSequentially(count: UInt, repeating f: @escaping(UInt, @escaping () -> Void) -> Void, _ last: @escaping () -> Void) {
    let first = (0..<count).reversed().reduce(last) { (prev: @escaping () -> Void, i: UInt) -> () -> Void in
        return { f(i, prev) }
    }

    first()
}
