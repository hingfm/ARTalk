//
//  ARTalkUITests.swift
//  ARTalkUITests
//
//  Created by Hing Chung on 18/1/2024.
//

import XCTest

final class ARTalkUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testLoginButtonTap() throws {
        // Assuming tapping the register button navigates to another view controller
        app.buttons["Login"].tap()
        // Add assertions here to check for the presence of elements in the new view controller
    }
    
    func testRegisterButtonTap() throws {
        // Assuming tapping the register button navigates to another view controller
        app.buttons["Register"].tap()
        // Add assertions here to check for the presence of elements in the new view controller
    }

    func testUIElementsExistence() throws {
        app.buttons["Register"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let emailTextField = app.textFields["New Email"]
        XCTAssertTrue(emailTextField.exists)

        let passwordTextField = app.secureTextFields["New Password"]
        XCTAssertTrue(passwordTextField.exists)

        let registerButton = app.buttons["Register"]
        XCTAssertTrue(registerButton.exists)
    }
    
    func testUserCanEnterEmailAndPassword() throws {
        app.buttons["Login"].tap()
        let emailTextField = app.textFields["Email Address"]
        emailTextField.tap()
        emailTextField.typeText("user@example.com")

        let passwordTextField = app.secureTextFields["Password"]
        passwordTextField.tap()
        passwordTextField.typeText("password123")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
