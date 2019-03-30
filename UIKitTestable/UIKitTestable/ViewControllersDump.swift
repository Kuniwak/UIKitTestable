public func info(of viewController: UIViewController) -> String {
    return "\(typeName(of: viewController)) at \(address(of: viewController))"
}



public func typeName(of x: Any) -> String {
    return String(reflecting: type(of: x))
}



public func address<T: AnyObject>(of object: T) -> String {
    return String(format: "%p", unsafeBitCast(object, to: Int.self))
}



public func lldbHint<T: AnyObject>(for object: T) -> String {
    return "unsafeBitCast(\(address(of: object)), to: \(typeName(of: object)).self)"
}



public func dump(viewControllers: [UIViewController]) -> String {
    return dump(viewControllers.map(info(of:)))
}



private func dump(_ x: Any) -> String {
    var result = ""
    Swift.dump(x, to: &result)
    return result
}
