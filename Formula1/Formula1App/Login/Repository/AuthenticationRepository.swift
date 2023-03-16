//
//  AuthenticationRepository.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 15/3/23.
//

import Foundation

final class AuthenticationRepository {
    private let authenticationFirebaseDatasource: AuthenticationFirebaseDatasource
    @Published var messageError: String?
    
    init(authenticationFirebaseDatasource: AuthenticationFirebaseDatasource = AuthenticationFirebaseDatasource()) {
        self.authenticationFirebaseDatasource = authenticationFirebaseDatasource
    }
    
    func getCurrentUser() -> User? {
        authenticationFirebaseDatasource.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        if email.isEmpty || password.isEmpty {
            self.messageError = "Rellena los campos"
        } else {
            authenticationFirebaseDatasource.createNewUser(email: email,
                                                           password: password,
                                                           completionBlock: completionBlock)
        }
        
    }
    
    func login(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        if email.isEmpty || password.isEmpty {
            self.messageError = "Rellena los campos"
        } else {
            authenticationFirebaseDatasource.login(email: email,
                                                   password: password,
                                                   completionBlock: completionBlock)
        }
    }
    
    func logout() throws {
        try authenticationFirebaseDatasource.logout()
    }
    
    func getCurrentProvider() -> [LinkedAccounts] {
        authenticationFirebaseDatasource.currentProvider()
    }
    
    func linkEmailAndPassword(email: String, password: String, completionBlock: @escaping (Bool) -> Void) {
        authenticationFirebaseDatasource.linkEmailAndPassword(email: email,
                                                              password: password,
                                                              completionBlock: completionBlock)
    }
    
    func linkFacebook(completionBlock: @escaping (Bool) -> Void) {
        authenticationFirebaseDatasource.linkFacebook(completionBlock: completionBlock)
    }
    
    func loginFacebook(completionBlock: @escaping (Result<User, Error>) -> Void) {
        authenticationFirebaseDatasource.loginWithFacebook(completionBlock: completionBlock)
    }
}
