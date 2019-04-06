import UIKit



/// An enum for events that can be notified by UIViewControllers.
public enum ViewControllerEvent {
    /// An event that will be notified after the UIViewController was initialized.
    case didInit
    /// An event that will be notified after `viewDidLoad`.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621495-viewdidload)
    case viewDidLoad
    /// An event that will be notified after `viewWillAppear`.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621510-viewwillappear)
    case viewWillAppear(animated: Bool)
    /// An event that will be notified after `viewDidAppear`.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621423-viewdidappear)
    case viewDidAppear(animated: Bool)
    /// An event that will be notified after `viewWillDisappear`.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621485-viewwilldisappear)
    case viewWillDisappear(animated: Bool)
    /// An event that will be notified after `viewDidDisappear`.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621477-viewdiddisappear)
    case viewDidDisappear(animated: Bool)
    /// An event that will be notified after `viewWillLayoutSubviews`.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621437-viewwilllayoutsubviews)
    case viewWillLayoutSubviews
    /// An event that will be notified after `viewDidLayoutSubviews`.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621398-viewdidlayoutsubviews)
    case viewDidLayoutSubviews
    /// An event that will be notified after `viewLayoutMarginsDidChange`.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/2891114-viewlayoutmarginsdidchange)
    case viewLayoutMarginsDidChange
    /// An event that will be notified after `viewLayoutMarginsDidChange`.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/2891116-viewsafeareainsetsdidchange#)
    case viewSafeAreaInsetsDidChange
    /// An event that will be notified after `didMove`.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621405-didmove)
    case didMove(parent: UIViewController?)
    /// An event that will be notified after `willMove`.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621381-willmove)
    case willMove(parent: UIViewController?)
    /// An event that will be notified after `didReceiveMemoryWarning`.
    /// - SeeAlso: [Apple Developer Documentation](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621409-didreceivememorywarning)
    case didReceiveMemoryWarning
    /// An event that will be notified before the UIViewController is released.
    case willDeinit


    /// Returns the event name.
    public var name: Name {
        switch self {
        case .didInit:
            return .didInit
        case .viewDidLoad:
            return .viewDidLoad
        case .viewWillAppear:
            return .viewWillAppear
        case .viewDidAppear:
            return .viewDidAppear
        case .viewWillDisappear:
            return .viewWillDisappear
        case .viewDidDisappear:
            return .viewDidDisappear
        case .viewWillLayoutSubviews:
            return .viewWillLayoutSubviews
        case .viewDidLayoutSubviews:
            return .viewDidLayoutSubviews
        case .viewLayoutMarginsDidChange:
            return .viewLayoutMarginsDidChange
        case .viewSafeAreaInsetsDidChange:
            return .viewSafeAreaInsetsDidChange
        case .didMove:
            return .didMove
        case .willMove:
            return .willMove
        case .didReceiveMemoryWarning:
            return .didReceiveMemoryWarning
        case .willDeinit:
            return .willDeinit
        }
    }



    /// A enum for names of `ViewControllerEvent`.
    public enum Name: String, Equatable, Hashable, CustomStringConvertible {
        case didInit
        case viewDidLoad
        case viewWillAppear
        case viewDidAppear
        case viewWillDisappear
        case viewDidDisappear
        case viewWillLayoutSubviews
        case viewDidLayoutSubviews
        case viewLayoutMarginsDidChange
        case viewSafeAreaInsetsDidChange
        case didMove
        case willMove
        case didReceiveMemoryWarning
        case willDeinit


        public var description: String {
            return self.rawValue
        }
    }
}



extension ViewControllerEvent: Equatable {}



extension ViewControllerEvent: CustomDebugStringConvertible {
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
        case .viewLayoutMarginsDidChange:
            return ".viewLayoutMarginsDidChange"
        case .viewSafeAreaInsetsDidChange:
            return ".viewSafeAreaInsetsDidChange"
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
        case .willDeinit:
            return ".willDeinit"
        }
    }
}



extension ViewControllerEvent: CustomReflectable {
    public var customMirror: Mirror {
        return Mirror(self, children: [])
    }
}
