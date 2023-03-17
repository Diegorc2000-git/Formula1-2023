//
//  LoginUITesting.swift
//  LoginUITesting
//
//  Created by Diego Rodriguez Casillas on 14/3/23.
//

import XCTest

class whenUserClicksOnLoginButtonAndSigninButton: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }
    // MARK: Error Cuando el usuario haga login e introduzca unas credenciales incorrectas
    func testShouldDisplayErrorMessageForErrorInCredentialsFailureLogin() {
        //Entrar en login Email
        app.buttons["Entrar con Email"].tap()
        //Introducir un email
        let usernameTextField = app.textFields["usernameTextField"]
        usernameTextField.tap()
        usernameTextField.typeText("d@d.com")
        //Introducir una contraseña > que 6
        let passwordTextField = app.textFields["passwordTextField"]
        passwordTextField.tap()
        passwordTextField.typeText("123456789")
        //Hacer Login
        app.buttons["loginButton"].tap()
        // Tiene que salir el error de "Usuario o contraseña incorrecta"
        let messageText = app.staticTexts["messageText"]
        XCTAssertEqual(messageText.label, "Usuario o contraseña incorrecta")
        
    }
    // MARK: Error Cuando el usuario haga login e introduzca en la contraseña menos de 6 digitos
    func testShouldDisplayErrorMessageForPasswordMustBeMoreThanSixDigitsInLogin() {
        //Entrar en login Email
        app.buttons["Entrar con Email"].tap()
        
        //Introducir un email
        let usernameTextField = app.textFields["usernameTextField"]
        usernameTextField.tap()
        usernameTextField.typeText("d@d.com")
        
        //Introducir una contraseña
        let passwordTextField = app.textFields["passwordTextField"]
        passwordTextField.tap()
        passwordTextField.typeText("12345")
        
        //Hacer Login
        app.buttons["loginButton"].tap()
        
        // Tiene que salir el error de "La contraseña tiene que ser de al menos 6 digitos"
        let messageText = app.staticTexts["messageText"]
        XCTAssertEqual(messageText.label, "La contraseña tiene que ser de al menos 6 digitos")
        
    }
    // MARK: Error Cuando el usuario haga signIn e introduzca un email incorecto
    func testShouldDisplayErrorMessageForErrorInEmailCredentialsFailureSignin() {
        //Entrar en SignIn
        app.buttons["registerButton"].tap()
        //Introducir un email
        let usernameTextField = app.textFields["usernameTextField"]
        usernameTextField.tap()
        usernameTextField.typeText("d@d")
        //Introducir una contraseña > que 6
        let passwordTextField = app.textFields["passwordTextField"]
        passwordTextField.tap()
        passwordTextField.typeText("123456")
        //Hacer SignIn
        app.buttons["signInButton"].tap()
        // Tiene que salir el error de "El email introducido es incorrecto, ejemplo@gmail.com"
        let messageText = app.staticTexts["messageText"]
        XCTAssertEqual(messageText.label, "El email introducido es incorrecto, ejemplo@gmail.com")
        
    }
    // MARK: Error Cuando el usuario haga signIn e introduzca en la contraseña menos de 6 digitos
    func testShouldDisplayErrorMessageForPasswordMustBeMoreThanSixDigitsInSignin() {
        //Entrar en SignIn
        app.buttons["registerButton"].tap()
        //Introducir un email
        let usernameTextField = app.textFields["usernameTextField"]
        usernameTextField.tap()
        usernameTextField.typeText("d@d.com")
        //Introducir una contraseña
        let passwordTextField = app.textFields["passwordTextField"]
        passwordTextField.tap()
        passwordTextField.typeText("12345")
        //Hacer Login
        app.buttons["signInButton"].tap()
        // Tiene que salir el error de "La contraseña tiene que ser de al menos 6 digitos"
        let messageText = app.staticTexts["messageText"]
        XCTAssertEqual(messageText.label, "La contraseña tiene que ser de al menos 6 digitos")
        
    }
    
}
