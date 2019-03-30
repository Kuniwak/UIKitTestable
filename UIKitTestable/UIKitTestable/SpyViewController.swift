import UIKit



/**
 A spy class for UIViewController.
 This class is useful for capturing calls of life-cycle event handlers.
 */
public func spyViewController() -> ObservingViewController {
    return ObservingViewController()
}
