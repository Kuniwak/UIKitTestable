/// Returns debug information for the specified view controller.
/// - Parameters:
///     - viewController: An view controller to need to see its information.
/// - Returns: The type name of the view controller with the memory address of its instance For example,
///   `"UIKitTestableTests.DebugTests.ExampleViewController at 0x7f9235564fb"`
public func info(of viewController: UIViewController) -> String {
    return "\(typeName(of: viewController)) at \(address(of: viewController))"
}



/// Returns a type name with a namespace where the type is defined at.
/// - Parameters:
///     - x: Any.
/// - Returns: The type name with a namespace where the type is defined.
public func typeName(of x: Any) -> String {
    return String(reflecting: type(of: x))
}



/// Returns a memory address of the object.
/// - Parameters:
///     - x: Any object.
/// - Returns: The memory address of the object such as `"0x7f9237bc2940"`.
public func address<T: AnyObject>(of object: T) -> String {
    return String(format: "%p", unsafeBitCast(object, to: Int.self))
}



/// Returns a LLDB code snippet to get the specified object on LLDB. For example, the return value is
/// `unsafeBitCast(0x7f9237a44080, to: UIKitTestableTests.DebugTests.ExampleViewController.self`, then you can use it by:
///
/// ```
/// (lldb) po unsafeBitCast(0x7faeb8c2b200, to: UIKitTestableTests.DebugTests.ExampleViewController.self)
/// <_TtCC18UIKitTestableTests10DebugTests21ExampleViewController: 0x7faeb8c2b200>
/// ```
///
/// - Parameters:
///     - x: Any object.
/// - Returns: A LLDB code snippet to get the specified object.
public func lldbHint<T: AnyObject>(for object: T) -> String {
    return "unsafeBitCast(\(address(of: object)), to: \(typeName(of: object)).self)"
}



/// Returns a result of `Swift.dump()` as a String instead of printing any logs.
/// - Parameters:
///     - x: Any.
/// - Returns: A result of `Swift.dump()` as a String.
public func dumped(_ x: Any) -> String {
    var result = ""
    dump(x, to: &result)
    return result
}


/// A specialized version of `dumped(_:Any)`.
/// - Parameters:
///     - viewControllers: `UIViewController`s.
/// - Returns: A result of `Swift.dump()` as a String.
public func dumped(viewControllers: [UIViewController]) -> String {
    return dumped(viewControllers.map(info(of:)))
}
