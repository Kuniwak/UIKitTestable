import UIKit



public class GlobalModalBackgroundViewController: UIViewController {
    private var firstViewDidAppearCallback: ((UIViewController) -> Void)?


    public init(_ firstViewDidAppearCallback: @escaping (UIViewController) -> Void) {
        self.firstViewDidAppearCallback = firstViewDidAppearCallback

        super.init(nibName: nil, bundle: nil)
    }


    public required init?(coder aDecoder: NSCoder) {
        return nil
    }


    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
    }


    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let firstViewDidAppearCallback = self.firstViewDidAppearCallback else {
            return
        }

        firstViewDidAppearCallback(self)
        self.firstViewDidAppearCallback = nil
    }
}
