internal func dumped<T>(_ value: T) -> String {
    var result = ""
    Swift.dump(value, to: &result)
    return result
}
