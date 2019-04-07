import XCTest
import UIKitTestable



/// An live usages for `GlobalModalPresenter`s.
/// You can see the the actual code by clicking "Show on GitHub".
class GlobalModalPresenterUsages: XCTestCase {
    /// An example class that use `GlobalModalPresenter`.
    /// It can be a ViewModel or Presenter (in MVP) or Router or whatever you want.
    class AnyViewModelOrPresenterOrWhatever {
        /// A `GlobalModalPresenter` should held as a read-only private stored property.
        private let globalPresenter: GlobalModalPresenterProtocol


        /// A flag that become true if the completion of `GlobalModalPresenter` is called.
        public private(set) var isCompletionCalled = false


        /// A GlobalModalPresenter should passed when initializing.
        init(globalPresenter: GlobalModalPresenterProtocol) {
            self.globalPresenter = globalPresenter
        }


        /// A method that need to present some UIViewControllers on the top of view hierarchy unconditionally.
        func showSomeModal() {
            let alertController = UIAlertController()

            // Do something.

            // Present the UIAlertController via `GlobalModalPresenter`.
            self.globalPresenter.present(viewController: alertController, animated: false) {
                self.isCompletionCalled = true
            }
        }
    }


    /// An usage for production use.
    /// - Remark: This case should not be a test case because preventing its side-effects is hard.
    func productionUsage() {
        let window = UIWindow()
        let globalPresenter = WindowModalPresentDismisser(wherePresentOn: .weak(window))
        let whatever = AnyViewModelOrPresenterOrWhatever(globalPresenter: globalPresenter)

        whatever.showSomeModal()
    }


    /// An usage of a stub for testing.
    func testSyncStubUsage() {
        let whatever = AnyViewModelOrPresenterOrWhatever(globalPresenter: syncStub())

        whatever.showSomeModal()

        // The completion is immediately called.
        XCTAssertTrue(whatever.isCompletionCalled)
    }


    /// An usage of a stub for testing.
    func testAsyncStubUsage() {
        let whatever = AnyViewModelOrPresenterOrWhatever(globalPresenter: asyncStub())

        whatever.showSomeModal()

        // The completion is not called yet because it is an asynchronous operation.
        XCTAssertFalse(whatever.isCompletionCalled)
    }


    /// An usage of a stub for testing.
    func testNeverStubUsage() {
        let whatever = AnyViewModelOrPresenterOrWhatever(globalPresenter: neverStub())

        whatever.showSomeModal()

        // The completion will be never called.
        XCTAssertFalse(whatever.isCompletionCalled)
    }


    /// An usage of a stub for testing.
    func testManualStubUsage() throws {
        let stub = GlobalModalPresenterManualStub()
        let whatever = AnyViewModelOrPresenterOrWhatever(globalPresenter: stub)

        whatever.showSomeModal()

        // The completion is not called until calling `complete()`.
        XCTAssertFalse(whatever.isCompletionCalled)

        try stub.complete()

        // The completion was called.
        XCTAssertTrue(whatever.isCompletionCalled)
    }
}