/// An error that thrown when trying to call a completion but the completion is nil.
public struct NoSuchCompletions: Error, Equatable {
    public init() {}
}


/// An error that thrown when trying to access the weak value but the value was released.
public struct InvalidAccessToReleasedWeakValue: Error, Equatable {
    public init() {}
}



/// An error that thrown when trying to pop to UIViewController that is not in the navigation stack.
public struct NoSuchDestinationViewControllerInNavigationStack: Error, CustomStringConvertible, Equatable {
    public let description: String


    public init(debugInfo: String) {
        self.description = debugInfo
    }


    public init(
        navigationController: UINavigationController,
        destinationViewController: UIViewController
    ) {
        let debugInfo = """
                        No such destination: \(info(of: destinationViewController))

                        The navigation stack of \(info(of: navigationController)) is:
                        \(dumped(viewControllers: navigationController.viewControllers))
                        """
        self.init(debugInfo: debugInfo)
    }
}
