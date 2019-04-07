import XCTest
import UIKitTestable



/// An live usages for `ModalPresenter`s.
/// You can see the the actual code by clicking "Show on GitHub".
class ModalPresenterUsages: XCTestCase {
    /// An example class that use `ModalPresenter`.
    /// It can be a ViewModel or Presenter (in MVP) or Router or whatever you want.
    class AnyViewModelOrPresenterOrWhatever {
        /// A `ModalPresenter` should held as a read-only private stored property.
        private let presenter: ModalPresenterProtocol


        /// A flag that become true if the completion of `ModalPresenter` is called.
        public private(set) var isCompletionCalled = false


        /// A ModalPresenter should passed when initializing.
        init(presenter: ModalPresenterProtocol) {
            self.presenter = presenter
        }


        /// A method that need to present some UIViewControllers.
        func showSomeModal() {
            let alertController = UIAlertController()

            // Do something.

            // Present the UIAlertController via `ModalPresenter`.
            self.presenter.present(viewController: alertController, animated: false) {
                self.isCompletionCalled = true
            }
        }
    }


    /// An usage for production use.
    /// - Remark: This case should not be a test case because preventing its side-effects is hard.
    func productionUsage() {
        let groundViewController = UIViewController()

        let presenter = ModalPresenter(wherePresentOn: .weak(groundViewController))
        let whatever = AnyViewModelOrPresenterOrWhatever(presenter: presenter)

        whatever.showSomeModal()
    }


    /// An usage of a stub for testing.
    func testSyncStubUsage() {
        let whatever = AnyViewModelOrPresenterOrWhatever(presenter: syncStub())

        whatever.showSomeModal()

        // The completion is immediately called.
        XCTAssertTrue(whatever.isCompletionCalled)
    }


    /// An usage of a stub for testing.
    func testAsyncStubUsage() {
        let whatever = AnyViewModelOrPresenterOrWhatever(presenter: asyncStub())

        whatever.showSomeModal()

        // The completion is not called yet because it is an asynchronous operation.
        XCTAssertFalse(whatever.isCompletionCalled)
    }


    /// An usage of a stub for testing.
    func testNeverStubUsage() {
        let whatever = AnyViewModelOrPresenterOrWhatever(presenter: neverStub())

        whatever.showSomeModal()

        // The completion will be never called.
        XCTAssertFalse(whatever.isCompletionCalled)
    }


    /// An usage of a stub for testing.
    func testManualStubUsage() throws {
        let stub = ModalPresenterManualStub()
        let whatever = AnyViewModelOrPresenterOrWhatever(presenter: stub)

        whatever.showSomeModal()

        // The completion is not called until calling `complete()`.
        XCTAssertFalse(whatever.isCompletionCalled)

        try stub.complete()

        // The completion was called.
        XCTAssertTrue(whatever.isCompletionCalled)
    }
}
