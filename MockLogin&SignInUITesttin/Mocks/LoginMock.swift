//
//  LoginMock.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 16/3/23.
//

import Foundation

class LoginMock: NetworkService {
    
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        
    }
    
    func logout() throws {
        
    }
    
    func getCurrentUser() -> User? {
        let authenticationFirebaseDatasource = AuthenticationFirebaseDatasource()
        return authenticationFirebaseDatasource.getCurrentUser()
    }

    func getCurrentProvider() -> [LinkedAccounts] {
        let authenticationFirebaseDatasource = AuthenticationFirebaseDatasource()
        return authenticationFirebaseDatasource.currentProvider()
    }

    func linkEmailAndPassword(email: String, password: String, completionBlock: @escaping (Bool) -> Void) {
        
    }
    
    func linkFacebook(completionBlock: @escaping (Bool) -> Void) {
        
    }
    
    func loginFacebook(completionBlock: @escaping (Result<User, Error>) -> Void) {
        
    }
    
    
    func login(email: String, password: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        
        if email == "d@d.com" && password == "123456" {
            completionBlock(.success(User(email: email)))
        } else {
            completionBlock(.failure(Error.self as! Error))
        }
    }
    
}
