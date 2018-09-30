import UIKit



public class CountedViewController: UIViewController {
    public private(set) static var numberOfLiving: UInt = 0


    public init() {
        CountedViewController.numberOfLiving += 1
        super.init(nibName: nil, bundle: nil)
    }


    public required init?(coder aDecoder: NSCoder) {
        return nil
    }


    deinit {
        CountedViewController.numberOfLiving -= 1
    }
}