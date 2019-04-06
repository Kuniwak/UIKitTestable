import UIKit



/**
 Returns a UIViewController for debugging its life cycle events.

 The returned UIViewController will print when a its life cycle event is fired as the following:

 ```
 .didInit
 .viewDidLoad
 .viewWillAppear(animated: true)
 .viewLayoutMarginsDidChange
 .viewSafeAreaInsetsDidChange
 .viewWillLayoutSubviews
 .viewDidLayoutSubviews
 .viewDidAppear(animated: true)

 ```
 */
public func debugViewController() -> ObservationViewController {
    return debugViewController(forWritingTo: StdoutPrinter())
}



/// debugViewController for its tests.
internal func debugViewController(forWritingTo printer: PrinterProtocol) -> ObservationViewController {
    return ObservationViewController { _, event in
        printer.print(event.debugDescription)
    }
}