import UIKit



/// A UIViewController for life cycle events observation.
/// - SeeAlso: `SpyViewControllerUsages`
public final class ObservationViewController: UIViewController {
    /// Events that can be observer by ObservingViewControllers.
    public typealias Event = ViewControllerEvent

    /// History of events happened.
    public private(set) var history: [Event] = []

    private let observer: ((ObservationViewController, Event) -> Void)?


    /// - Parameters:
    ///   - observer: Callback will called when every life cycle events are happened.
    public init(
        _ observer: ((ObservationViewController, Event) -> Void)? = nil
    ) {
        self.observer = observer

        super.init(nibName: nil, bundle: nil)

        self.on(event: .didInit)
    }


    public required init?(coder aDecoder: NSCoder) {
        return nil
    }


    deinit {
        self.on(event: .willDeinit)
    }


    private func on(event: Event) {
        self.history.append(event)
        self.observer?(self, event)
    }


    public override func viewDidLoad() {
        super.viewDidLoad()
        self.on(event: .viewDidLoad)
    }


    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.on(event: .viewWillAppear(animated: animated))
    }


    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.on(event: .viewDidAppear(animated: animated))
    }


    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.on(event: .viewWillDisappear(animated: animated))
    }


    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.on(event: .viewDidDisappear(animated: animated))
    }


    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.on(event: .viewWillLayoutSubviews)
    }


    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.on(event: .viewDidLayoutSubviews)
    }


    public override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        self.on(event: .didMove(parent: parent))
    }


    public override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        self.on(event: .willMove(parent: parent))
    }


    public override func viewLayoutMarginsDidChange() {
        super.viewLayoutMarginsDidChange()
        self.on(event: .viewLayoutMarginsDidChange)
    }


    public override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        self.on(event: .viewSafeAreaInsetsDidChange)
    }


    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.on(event: .didReceiveMemoryWarning)
    }
}
