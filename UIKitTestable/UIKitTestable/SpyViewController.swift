import UIKit



/**
 A spy class for UIViewController.
 This class is useful for capturing calls of life-cycle event handlers.
 */
public class SpyViewController: UIViewController {
    public enum CallArgs: Equatable {
        case viewDidDisappear(animated: Bool)
        case viewDidAppear(animated: Bool)
    }


    /**
     Call arguments list for the life-cycle event handlers.
     You can use the property to test how the method is called.
     */
    public private(set) var callArgs: [CallArgs] = []


    public override func viewDidAppear(_ animated: Bool) {
        self.callArgs.append(.viewDidAppear(animated: animated))
        super.viewDidAppear(animated)
    }


    public override func viewDidDisappear(_ animated: Bool) {
        self.callArgs.append(.viewDidDisappear(animated: animated))
        super.viewDidDisappear(animated)
    }
}
