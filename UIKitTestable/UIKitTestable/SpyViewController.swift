import UIKit



/// A spy class for `UIViewController`s.
/// This class is useful for capturing calls of life-cycle event handlers.
/// - SeeAlso: `SpyViewControllerUsages`.
public func spyViewController() -> ObservationViewController {
    return ObservationViewController()
}
