public enum WeakOrNotReference {
    case weak(Weak<AnyObject>)
    case notReference


    public var weak: Weak<AnyObject>? {
        switch self {
        case .weak(let container):
            return container
        case .notReference:
            return nil
        }
    }


    public static func from<T>(_ target: T) -> WeakOrNotReference {
        switch Mirror(reflecting: target).displayStyle {
        case .some(.class):
            return .weak(Weak(target as AnyObject))
        default:
            return .notReference
        }
    }
}