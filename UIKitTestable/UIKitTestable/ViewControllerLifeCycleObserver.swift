import UIKit



public enum ViewControllerLifeCycleEvent: Equatable {
    case initialized
    case viewDidLoad
    case viewWillAppear(animated: Bool)
    case viewDidAppear(animated: Bool)
    case viewWillDisappear(animated: Bool)
    case viewDidDisappear(animated: Bool)
    case viewWillLayoutSubviews
    case viewDidLayoutSubviews
    case didMove(parent: UIViewController?)
    case willMove(parent: UIViewController?)
    case didReceiveMemoryWarning
    case viewWillTransition(size: CGSize, coordinator: UIViewControllerTransitionCoordinator)
    case deinitialized


    public static func ==(lhs: ViewControllerLifeCycleEvent, rhs: ViewControllerLifeCycleEvent) -> Bool {
        switch (lhs, rhs) {
        case (.initialized, .initialized):
            return true
        case (.viewDidLoad, .viewDidLoad):
            return true
        case (.viewWillAppear(animated: let l), .viewWillAppear(animated: let r)):
            return l == r
        case (.viewDidAppear(animated: let l), .viewDidAppear(animated: let r)):
            return l == r
        case (.viewWillDisappear(animated: let l), .viewWillDisappear(animated: let r)):
            return l == r
        case (.viewDidDisappear(animated: let l), .viewDidDisappear(animated: let r)):
            return l == r
        case (.viewWillLayoutSubviews, .viewWillLayoutSubviews):
            return true
        case (.viewDidLayoutSubviews, .viewDidLayoutSubviews):
            return true
        case (.didMove(parent: let l), .didMove(parent: let r)):
            return l == r
        case (.willMove(parent: let l), .willMove(parent: let r)):
            return l == r
        case (.didReceiveMemoryWarning, .didReceiveMemoryWarning):
            return true
        case (.viewWillTransition(size: let ls, coordinator: let lc), .viewWillTransition(size: let rs, coordinator: let rc)):
            return ls == rs && lc.isEqual(rc)
        case (.deinitialized, .deinitialized):
            return true
        default:
            return false
        }
    }
}



open class ViewControllerLifeCycleObserver: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)

        self.handle(lifeCycleEvent: .initialized)
    }


    public required init?(coder aDecoder: NSCoder) {
        return nil
    }


    deinit {
        self.handle(lifeCycleEvent: .deinitialized)
    }


    open func handle(lifeCycleEvent: ViewControllerLifeCycleEvent) {
        // NOTE: Override me.
    }


    open override func viewDidLoad() {
        super.viewDidLoad()
        self.handle(lifeCycleEvent: .viewDidLoad)
    }


    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.handle(lifeCycleEvent: .viewWillAppear(animated: animated))
    }


    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.handle(lifeCycleEvent: .viewDidAppear(animated: animated))
    }


    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.handle(lifeCycleEvent: .viewWillDisappear(animated: animated))
    }


    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.handle(lifeCycleEvent: .viewDidDisappear(animated: animated))
    }


    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.handle(lifeCycleEvent: .viewWillLayoutSubviews)
    }


    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.handle(lifeCycleEvent: .viewDidLayoutSubviews)
    }


    open override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        self.handle(lifeCycleEvent: .didMove(parent: parent))
    }


    open override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        self.handle(lifeCycleEvent: .willMove(parent: parent))
    }


    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.handle(lifeCycleEvent: .didReceiveMemoryWarning)
    }


    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.handle(lifeCycleEvent: .viewWillTransition(size: size, coordinator: coordinator))
    }
}
