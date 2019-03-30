import UIKit



public enum ViewControllerLifeCycleEvent {
    case didInit
    case viewDidLoad
    case viewWillAppear(animated: Bool)
    case viewDidAppear(animated: Bool)
    case viewWillDisappear(animated: Bool)
    case viewDidDisappear(animated: Bool)
    case viewWillLayoutSubviews
    case viewDidLayoutSubviews
    case didMove(parent: UIViewController?)
    case willMove(parent: UIViewController?)
    case didReceiveMemoryWarning
    case viewWillTransition(size: CGSize, coordinator: UIViewControllerTransitionCoordinator)
    case willDeinit
}



extension ViewControllerLifeCycleEvent: Equatable {
    public static func ==(lhs: ViewControllerLifeCycleEvent, rhs: ViewControllerLifeCycleEvent) -> Bool {
        switch (lhs, rhs) {
        case (.didInit, .didInit):
            return true
        case (.viewDidLoad, .viewDidLoad):
            return true
        case (.viewWillAppear(animated: let l), .viewWillAppear(animated: let r)):
            return l == r
        case (.viewDidAppear(animated: let l), .viewDidAppear(animated: let r)):
            return l == r
        case (.viewWillDisappear(animated: let l), .viewWillDisappear(animated: let r)):
            return l == r
        case (.viewDidDisappear(animated: let l), .viewDidDisappear(animated: let r)):
            return l == r
        case (.viewWillLayoutSubviews, .viewWillLayoutSubviews):
            return true
        case (.viewDidLayoutSubviews, .viewDidLayoutSubviews):
            return true
        case (.didMove(parent: let l), .didMove(parent: let r)):
            return l == r
        case (.willMove(parent: let l), .willMove(parent: let r)):
            return l == r
        case (.didReceiveMemoryWarning, .didReceiveMemoryWarning):
            return true
        case (.viewWillTransition(size: let ls, coordinator: let lc), .viewWillTransition(size: let rs, coordinator: let rc)):
            return ls == rs && lc.isEqual(rc)
        case (.willDeinit, .willDeinit):
            return true
        default:
            return false
        }
    }
}



extension ViewControllerLifeCycleEvent: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .didInit:
            return ".didInit"
        case .viewDidLoad:
            return ".viewDidLoad"
        case .viewWillAppear(animated: let animated):
            return ".viewWillAppear(animated: \(animated))"
        case .viewDidAppear(animated: let animated):
            return ".viewDidAppear(animated: \(animated))"
        case .viewWillLayoutSubviews:
            return ".viewWillLayoutSubviews"
        case .viewDidLayoutSubviews:
            return ".viewDidLayoutSubviews"
        case .viewWillDisappear(animated: let animated):
            return ".viewWillDisappear(animated: \(animated))"
        case .viewDidDisappear(animated: let animated):
            return ".viewDidDisappear(animated: \(animated))"
        case .willMove(parent: .some(let parent)):
            return ".willMove(parent: \(type(of: parent)))  (at \(address(of: parent))"
        case .willMove(parent: .none):
            return ".willMove(parent: nil)"
        case .didMove(parent: .some(let parent)):
            return ".didMove(parent: \(type(of: parent)))  (at \(address(of: parent))"
        case .didMove(parent: .none):
            return ".didMove(parent: nil)"
        case .didReceiveMemoryWarning:
            return ".didReceiveMemoryWarning"
        case .viewWillTransition(size: let size, coordinator: let coordinator):
            return ".viewWillTransition(size: CGSize(width: \(size.width), height: \(size.height)), coordinator: \(typeName(of: coordinator))  (at \(address(of: coordinator)))"
        case .willDeinit:
            return ".willDeinit"
        }
    }
}



extension ViewControllerLifeCycleEvent: CustomReflectable {
    public var customMirror: Mirror {
        return Mirror(self, children: [])
    }
}
