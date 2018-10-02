import UIKit



internal final class GlobalModalBackgroundViewController: UIViewController {
    private var firstViewDidAppearCallback: ((UIViewController) -> Void)?


    internal init(_ firstViewDidAppearCallback: @escaping (UIViewController) -> Void) {
        self.firstViewDidAppearCallback = firstViewDidAppearCallback

        super.init(nibName: nil, bundle: nil)
    }


    internal required init?(coder aDecoder: NSCoder) {
        return nil
    }


    internal override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
    }


    internal override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let firstViewDidAppearCallback = self.firstViewDidAppearCallback else {
            return
        }

        firstViewDidAppearCallback(self)
        self.firstViewDidAppearCallback = nil
    }
}
