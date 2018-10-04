public enum WeakOrUnowned<T: AnyObject> {
    case weak(Weak<T>)
    case unowned(Unowned<T>)


    public var weak: Weak<T>? {
        switch self {
        case .weak(let container):
            return container
        case .unowned:
            return nil
        }
    }


    public var unowned: Unowned<T>? {
        switch self {
        case .weak:
            return nil
        case .unowned(let container):
            return container
        }
    }
}



public class Weak<T: AnyObject> {
    public private(set) weak var value: T?


    public init(_ value: T) {
        self.value = value
    }


    public var isReleased: Bool {
        return self.value == nil
    }
}



public class Unowned<T: AnyObject> {
    public unowned var value: T


    public init(_ value: T) {
        self.value = value
    }
}