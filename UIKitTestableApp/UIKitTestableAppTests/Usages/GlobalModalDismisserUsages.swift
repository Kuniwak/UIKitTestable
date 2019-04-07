import XCTest
import UIKitTestable



/// An live usages for `GlobalModalDismisser`s.
/// You can see the the actual code by clicking "Show on GitHub".
class GlobalModalDismisserUsages: XCTestCase {
    /// An example class that use `GlobalModalDismisser`.
    /// It can be a ViewModel or Presenter (in MVP) or Router or whatever you want.
    class AnyViewModelOrPresenterOrWhatever {
        /// A `GlobalModalDismisser` should held as a read-only private stored property.
        private let globalDismisser: GlobalModalDismisserProtocol


        /// A flag that become true if the completion of `GlobalModalPresenter` is called.
        public private(set) var isCompletionCalled = false


        /// A GlobalModalPresenter should passed when initializing.
        init(globalDismisser: GlobalModalDismisserProtocol) {
            self.globalDismisser = globalDismisser
        }


        /// Hides a view controller that was presented by `GlobalModalPresenter`.
        func hideSomeModal() {
            // Do something.

            /// Present the UIAlertController via `GlobalModalPresenter`.
            self.globalDismisser.dismiss(animated: false) {
                self.isCompletionCalled = true
            }
        }
    }



    /// An usage for production use.
    /// - Remark: This case should not be a test case because preventing its side-effects is hard.
    func productionUsage() {
        let expectation = self.expectation(description: "Awaiting dismissing a global modal")

        let globalPresentDismisser = WindowModalPresentDismisser(wherePresentOn: .weak(UIWindow()))
        let anyViewController = spyViewController()
        let whatever = AnyViewModelOrPresenterOrWhatever(globalDismisser: globalPresentDismisser)

        globalPresentDismisser.present(viewController: anyViewController, animated: false) {
            whatever.hideSomeModal()
            expectation.fulfill()
        }

        self.waitForExpectations(timeout: 3.0)
    }


    /// An usage of a stub for testing.
    func testSyncStubUsage() {
        let whatever = AnyViewModelOrPresenterOrWhatever(globalDismisser: syncStub())

        whatever.hideSomeModal()

        XCTAssertTrue(whatever.isCompletionCalled)
    }


    /// An usage of a stub for testing.
    func testAsyncStubUsage() {
        let whatever = AnyViewModelOrPresenterOrWhatever(globalDismisser: asyncStub())

        whatever.hideSomeModal()

        XCTAssertFalse(whatever.isCompletionCalled)
    }


    /// An usage of a stub for testing.
    func testNeverStubUsage() {
        let whatever = AnyViewModelOrPresenterOrWhatever(globalDismisser: neverStub())

        whatever.hideSomeModal()

        XCTAssertFalse(whatever.isCompletionCalled)
    }


    /// An usage of a stub for testing.
    func testManualStubUsage() throws {
        let manualStub = GlobalModalDismisserManualStub()
        let whatever = AnyViewModelOrPresenterOrWhatever(globalDismisser: manualStub)

        whatever.hideSomeModal()

        XCTAssertFalse(whatever.isCompletionCalled)
        try manualStub.complete()
        XCTAssertTrue(whatever.isCompletionCalled)
    }
}