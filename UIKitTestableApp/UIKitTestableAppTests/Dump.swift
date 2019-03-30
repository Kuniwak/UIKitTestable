internal func dump<T>(_ value: T) -> String {
    var result = ""
    Swift.dump(value, to: &result)
    return result
}
