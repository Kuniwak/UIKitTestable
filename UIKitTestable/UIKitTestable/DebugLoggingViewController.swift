import UIKit



internal final class DebugLoggingViewController: ViewControllerLifeCycleObserver {
    override public init() {
        super.init()
    }


    internal required init?(coder aDecoder: NSCoder) {
        return nil
    }


    internal override func handle(lifeCycleEvent: ViewControllerLifeCycleEvent) {
        print("\(self): \(lifeCycleEvent)")
    }
}