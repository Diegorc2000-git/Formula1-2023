//
//  MockingLoginUI.swift
//  MockingLoginUI
//
//  Created by Diego Rodriguez Casillas on 14/3/23.
//

import XCTest
@testable 

class when_user_clicks_on_login_button: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
    }
    
    func test_should_display_error_message_for_missing_required_fields() {
        
        let usernameTextField = app.textFields["usernameTextField"]
        usernameTextField.tap()
        usernameTextField.typeText("")
        
        let passwordTextField = app.textFields["passwordTextField"]
        passwordTextField.tap()
        passwordTextField.typeText("")
        
        let loginButton = app.buttons["loginButton"]
        loginButton.tap()
        
        let messageText = app.staticTexts["messageText"]
        
        XCTAssertEqual(messageText.label, "Required fields are missing")
        
    }
    
    func test_should_navigate_to_dashboard_page_when_authenticated() {
        
        let usernameTextField = app.textFields["usernameTextField"]
        usernameTextField.tap()
        usernameTextField.typeText("JohnDoe")
        
        let passwordTextField = app.textFields["passwordTextField"]
        passwordTextField.tap()
        passwordTextField.typeText("Password")
        
        let loginButton = app.buttons["loginButton"]
        loginButton.tap()
        
        let dashboardNavBarTitle = app.staticTexts["Dashboard"]
        XCTAssertTrue(dashboardNavBarTitle.waitForExistence(timeout: 0.5))
        
    }
    
}
