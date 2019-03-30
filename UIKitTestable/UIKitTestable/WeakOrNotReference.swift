public enum WeakOrNotReferenceType {
    case weak(Weak<AnyObject>)
    case notReferenceType


    public var weak: Weak<AnyObject>? {
        switch self {
        case .weak(let container):
            return container
        case .notReferenceType:
            return nil
        }
    }


    public init<T>(_ target: T) {
        switch Mirror(reflecting: target).displayStyle {
        case .some(.class):
            self = .weak(Weak(target as AnyObject))
        default:
            self = .notReferenceType
        }
    }
}