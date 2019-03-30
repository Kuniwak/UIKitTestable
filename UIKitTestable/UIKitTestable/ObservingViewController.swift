import UIKit



public final class ObservingViewController: UIViewController {
    public typealias Event = ViewControllerLifeCycleEvent
    public private(set) var history: [Event] = []


    private let shouldPrintEvents: Bool
    private let observer: ((ObservingViewController, Event) -> Void)?


    public init(shouldPrintEvents: Bool = false, _ observer: ((ObservingViewController, Event) -> Void)? = nil) {
        self.shouldPrintEvents = shouldPrintEvents
        self.observer = observer

        super.init(nibName: nil, bundle: nil)

        self.on(lifeCycleEvent: .didInit)
    }


    public required init?(coder aDecoder: NSCoder) {
        return nil
    }


    deinit {
        self.on(lifeCycleEvent: .willDeinit)
    }


    private func on(lifeCycleEvent: Event) {
        if self.shouldPrintEvents {
            print(lifeCycleEvent)
        }
        self.history.append(lifeCycleEvent)
        self.observer?(self, lifeCycleEvent)
    }


    public override func viewDidLoad() {
        super.viewDidLoad()
        self.on(lifeCycleEvent: .viewDidLoad)
    }


    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.on(lifeCycleEvent: .viewWillAppear(animated: animated))
    }


    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.on(lifeCycleEvent: .viewDidAppear(animated: animated))
    }


    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.on(lifeCycleEvent: .viewWillDisappear(animated: animated))
    }


    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.on(lifeCycleEvent: .viewDidDisappear(animated: animated))
    }


    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.on(lifeCycleEvent: .viewWillLayoutSubviews)
    }


    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.on(lifeCycleEvent: .viewDidLayoutSubviews)
    }


    public override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        self.on(lifeCycleEvent: .didMove(parent: parent))
    }


    public override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        self.on(lifeCycleEvent: .willMove(parent: parent))
    }


    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.on(lifeCycleEvent: .didReceiveMemoryWarning)
    }


    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.on(lifeCycleEvent: .viewWillTransition(size: size, coordinator: coordinator))
    }
}
