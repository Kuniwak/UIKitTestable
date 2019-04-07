import XCTest
import UIKitTestable



/// An live usages for `ModalDismisser`s.
/// You can see the the actual code by clicking "Show on GitHub".
class ModalDismisserUsages: XCTestCase {
    /// An example class that use `ModalDismisser`.
    /// It can be a ViewModel or Presenter (in MVP) or Router or whatever you want.
    class AnyViewModelOrPresenterOrWhatever {
        /// A `ModalDismisser` should held as a read-only private stored property.
        private let dismisser: ModalDismisserProtocol


        /// A flag that become true if the completion of `ModalPresenter` is called.
        public private(set) var isCompletionCalled = false


        /// A ModalPresenter should passed when initializing.
        init(dismisser: ModalDismisserProtocol) {
            self.dismisser = dismisser
        }


        /// Hides a view controller that was presented by `ModalPresenter`.
        func hideSomeModal() {
            // Do something.

            /// Present the UIAlertController via `ModalPresenter`.
            self.dismisser.dismiss(animated: false) {
                self.isCompletionCalled = true
            }
        }
    }



    /// An usage for production use.
    /// - Remark: This case should not be a test case because preventing its side-effects is hard.
    func productionUsage() {
        let anyViewController = spyViewController()

        let dismisser = ModalDismisser(willDismiss: .weak(anyViewController))
        let whatever = AnyViewModelOrPresenterOrWhatever(dismisser: dismisser)

        whatever.hideSomeModal()
    }


    /// An usage of a stub for testing.
    func testSyncStubUsage() {
        let whatever = AnyViewModelOrPresenterOrWhatever(dismisser: syncStub())

        whatever.hideSomeModal()

        // The completion is immediately called.
        XCTAssertTrue(whatever.isCompletionCalled)
    }


    /// An usage of a stub for testing.
    func testAsyncStubUsage() {
        let whatever = AnyViewModelOrPresenterOrWhatever(dismisser: asyncStub())

        whatever.hideSomeModal()

        // The completion is not called yet because it is an asynchronous operation.
        XCTAssertFalse(whatever.isCompletionCalled)
    }


    /// An usage of a stub for testing.
    func testNeverStubUsage() {
        let whatever = AnyViewModelOrPresenterOrWhatever(dismisser: neverStub())

        whatever.hideSomeModal()

        // The completion will be never called.
        XCTAssertFalse(whatever.isCompletionCalled)
    }


    /// An usage of a stub for testing.
    func testManualStubUsage() throws {
        let manualStub = ModalDismisserManualStub()
        let whatever = AnyViewModelOrPresenterOrWhatever(dismisser: manualStub)

        whatever.hideSomeModal()

        // The completion is not called until calling `complete()`.
        XCTAssertFalse(whatever.isCompletionCalled)

        try manualStub.complete()

        // The completion was called.
        XCTAssertTrue(whatever.isCompletionCalled)
    }
}
