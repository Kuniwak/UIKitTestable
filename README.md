UIKitTestable
=============

![Swift 5.0 compatible](https://img.shields.io/badge/Swift%20version-5.0-green.svg)
![Carthage](https://img.shields.io/badge/Carthage-compatible-green.svg)
[![MIT license](https://img.shields.io/badge/lisence-MIT-yellow.svg)](https://github.com/Kuniwak/UIKitTestable/blob/master/LICENSE)
[![Build Status](https://app.bitrise.io/app/cf31463e6b553102/status.svg?token=61qotT9hVzPoG4N-9TWU7A&branch=master)](https://app.bitrise.io/app/cf31463e6b553102)

UIKit becomes testable.



Usage
-----

### Testing with `UINavigationController.pushViewController(_:animated:)`

```swift
// BEFORE
import UIKit

class MyViewController: UIViewController {
    @IBAction func doSomething(_ sender: Any) {
        // Checking the whether pushViewController was called or not is hard.
        self.navigationController?.pushViewController(self)
    }
}
```

```swift
// AFTER
import UIKit
import UIKitTestable

class MyViewController: UIViewController {
    private let navigator: NavigatorProtocol

    @IBAction func doSomething(_ sender: Any) {
        // Easily inject a NavigatorStub or NavigatorSpy because they conform NavigatorProtocol.
        self.navigator.push(viewController: self)
    }
}
```

```swift
// MyViewControllerTests.swift
import XCTest
import UIKitTestable

class MyViewControllerTests: XCTestCase {
    func testDoSomething() {
        let navigatorSpy = NavigatorSpy()

        // Inject the spy to verify how many time the .push was called.
        let myViewController = MyViewController(navigatorSpy)

        myViewController.doSomething(nil)

        XCTAssertEqual(navigatorSpy.calledArgs.count, 1)
    }
}
```



### Testing with `UIViewController.present(_:animated:completion:)`

```swift
// BEFORE
import UIKit

class MyViewController: UIViewController {
    @IBAction func doSomething(_ sender: Any) {
        // Checking the whether present was called or not is hard.
        self.present(anotherViewController)
    }
}
```

```swift
// AFTER
import UIKit
import UIKitTestable

class MyViewController: UIViewController {
    private let modalPresenter: ModalPresenterProtocol

    @IBAction func doSomething(_ sender: Any) {
        // Easily inject a ModalPresenterStub or ModalPresenterSpy because they conform ModalPresenterProtocol.
        self.modalPresnter.present(viewController: anotherViewController)
    }
}
```

```swift
// MyViewControllerTests.swift
import XCTest
import UIKitTestable

class MyViewControllerTests: XCTestCase {
    func testDoSomething() {
        let modalPresenterSpy = ModalPresenterSpy()

        // Inject the spy to verify how many time the .present was called.
        let myViewController = MyViewController(modalPresenterSpy)

        myViewController.doSomething(nil)

        XCTAssertEqual(modalPresenterSpy.calledArgs.count, 1)
    }
}
```



Documentations
--------------

TODO





Installation
------------
### Carthage

Add the following line to your `Cartfile`:

```
github "Kuniwak/UIKitTestable"
```



### CocoaPods

Not supported yet. If you want to support CocoaPods, please send the patch.

