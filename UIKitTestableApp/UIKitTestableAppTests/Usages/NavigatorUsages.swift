import XCTest
import UIKitTestable



/// An live usages for `Navigator`s.
/// You can see the the actual code by clicking "Show on GitHub".
class NavigatorUsages: XCTestCase {
    /// An example class that use `Navigator`.
    /// It can be a ViewModel or Presenter (in MVP) or Router or whatever you want.
    class AnyViewModelOrPresenterOrWhatever {
        /// A `Navigator` should held as a read-only private stored property.
        private let navigator: NavigatorProtocol


        /// A flag that become true if the completion of `GlobalModalPresenter` is called.
        public private(set) var isCompletionCalled = false


        /// A GlobalModalPresenter should passed when initializing.
        init(navigator: NavigatorProtocol) {
            self.navigator = navigator
        }


        /// A method that need to push some view controllers.
        func goToNextScreen() {
            let anyViewController = spyViewController()

            // Do something.

            // Present the UIAlertController
            self.navigator.push(viewController: anyViewController, animated: false)
        }
    }


    /// An usage for production use.
    /// - Remark: This case should not be a test case because preventing its side-effects is hard.
    func productionUsage() {
        let navigationController = UINavigationController()
        let navigator = Navigator(for: .weak(navigationController))
        let whatever = AnyViewModelOrPresenterOrWhatever(navigator: navigator)

        whatever.goToNextScreen()
    }


    /// An usage of a stub for testing.
    func testStubUsage() {
        let whatever = AnyViewModelOrPresenterOrWhatever(navigator: stub())

        whatever.goToNextScreen()
    }


    /// An usage of a stub for testing.
    func testSpyUsage() {
        let spy = NavigatorSpy()
        let whatever = AnyViewModelOrPresenterOrWhatever(navigator: spy)

        whatever.goToNextScreen()

        XCTAssertEqual(spy.callArgs.count, 1)
    }
}
