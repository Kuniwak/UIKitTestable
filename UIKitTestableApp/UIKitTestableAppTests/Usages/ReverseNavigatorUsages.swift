import XCTest
import UIKitTestable



/// An live usages for `ReverseNavigator`s.
/// You can see the the actual code by clicking "Show on GitHub".
class ReverseNavigatorUsages: XCTestCase {
    /// An example class that use `ReverseNavigator`.
    /// It can be a ViewModel or Presenter (in MVP) or Router or whatever you want.
    class AnyViewModelOrPresenterOrWhatever {
        /// A `ReverseNavigator` should held as a read-only private stored property.
        private let reverseNavigator: ReverseNavigatorProtocol


        /// A flag that become true if the completion of `GlobalModalPresenter` is called.
        public private(set) var isCompletionCalled = false


        /// A GlobalModalPresenter should passed when initializing.
        init(reverseNavigator: ReverseNavigatorProtocol) {
            self.reverseNavigator = reverseNavigator
        }


        /// A method that need to pop to a view controller.
        func backToPreviousScreen() {
            // Do something.

            do {
                // Pop the navigation stack to the destination view controller.
                try self.reverseNavigator.pop(animated: false)
            }
            catch {
                // Print an error if the destination view controller is not in the navigation stack.
                dump(error)
            }
        }
    }


    /// An usage for production use.
    /// - Remark: This case should not be a test case because preventing its side-effects is hard.
    func productionUsage() {
        let destinationController = spyViewController()
        let navigationController = UINavigationController()

        let reverseNavigator = ReverseNavigator(willPopTo: .weak(destinationController), on: .weak(navigationController))
        let whatever = AnyViewModelOrPresenterOrWhatever(reverseNavigator: reverseNavigator)

        whatever.backToPreviousScreen()
    }


    /// An usage of a stub for testing.
    func testStubUsage() {
        let whatever = AnyViewModelOrPresenterOrWhatever(reverseNavigator: stub())

        whatever.backToPreviousScreen()
    }


    /// An usage of a stub for testing.
    func testSpyUsage() {
        let spy = ReverseNavigatorSpy()
        let whatever = AnyViewModelOrPresenterOrWhatever(reverseNavigator: spy)

        whatever.backToPreviousScreen()

        XCTAssertEqual(spy.callArgs.count, 1)
    }
}
