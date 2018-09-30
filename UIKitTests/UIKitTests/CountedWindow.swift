import UIKit



public class CountedWindow: UIWindow {
    public private(set) static var numberOfLiving: UInt = 0


    public init() {
        CountedWindow.numberOfLiving += 1
        super.init(frame: .zero)
    }


    public required init?(coder aDecoder: NSCoder) {
        return nil
    }


    deinit {
        CountedWindow.numberOfLiving -= 1
    }
}
