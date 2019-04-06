/// An error that raised when trying to call a completion but the completion is nil.
public struct NoSuchCompletions: Error, Equatable {
    public init() {}
}


/// An error that raised when trying to access the weak value but the value was released.
public struct InvalidAccessToReleasedWeakValue: Error, Equatable {
    public init() {}
}