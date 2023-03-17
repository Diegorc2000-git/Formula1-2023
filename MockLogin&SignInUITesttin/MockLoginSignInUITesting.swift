//
//  MockLoginSignInUITesting.swift
//  MockLogin&SignInUITesttin
//
//  Created by Diego Rodriguez Casillas on 16/3/23.
//

import XCTest

class whenUserClicksOnLoginButton: XCTestCase {

    private var app: XCUIApplication!//AÑADIR ! sino revienta
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
    }
    
    func testShouldDisplayErrorMessageForMissingRequiredFields() {
        
        app.buttons["Entrar con Email"].tap()
        
        let usernameTextField = app.textFields["usernameTextField"]
        usernameTextField.tap()
        usernameTextField.typeText("")
        
        let passwordTextField = app.textFields["passwordTextField"]
        passwordTextField.tap()
        passwordTextField.typeText("")
        
        let loginButton = app.buttons["loginButton"]
        loginButton.tap()
        
        let messageText = app.staticTexts["messageText"]
        
        XCTAssertEqual(messageText.label, "Rellena los campos obligatorios")
        
    }
    
    func testShouldNavigateToDashboardPageWhenAuthenticated() {
        
        app.buttons["Entrar con Email"].tap()
        
        let usernameTextField = app.textFields["usernameTextField"]
        usernameTextField.tap()
        usernameTextField.typeText("d@d.com")
        
        let passwordTextField = app.textFields["passwordTextField"]
        passwordTextField.tap()
        passwordTextField.typeText("123456")
        
        let loginButton = app.buttons["loginButton"]
        loginButton.tap()
        
        let dashboardNavBarTitle = app.staticTexts["Home"]
        XCTAssertTrue(dashboardNavBarTitle.waitForExistence(timeout: 0.5))
        
    }
    
}
