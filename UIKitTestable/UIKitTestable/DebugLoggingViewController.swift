import UIKit



/// Returns a UIViewController for debugging its life cycle events.
public func debugViewController() -> ObservationViewController {
    return ObservationViewController(shouldPrintEvents: true)
}