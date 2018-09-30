import UIKit



public class DebugLoggingViewController: ViewControllerLifeCycleObserver {
    override public init() {
        super.init()
    }


    public required init?(coder aDecoder: NSCoder) {
        return nil
    }


    public override func handle(lifeCycleEvent: ViewControllerLifeCycleEvent) {
        print("\(self): \(lifeCycleEvent)")
    }
}