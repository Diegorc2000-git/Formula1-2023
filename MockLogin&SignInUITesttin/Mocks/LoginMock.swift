//
//  LoginMock.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 16/3/23.
//

import Foundation

class LoginMock: NetworkService {
    func editProfile(username: String, bio: String, imageData: Data, onSuccess: @escaping (User) -> Void, onError: @escaping (String) -> Void) {
        
    }
    
    func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {

    }
    
    func signIn(email: String, password: String, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        if email == "d@d.com" && password == "123456" {
            //onSuccess(.success(User(uid: "", email: email, profileImageUrl: "", bio: "", username: "")))
        } else {
            //onError(.failure(Error.self as! Error))
        }
    }
    
    func logout() throws {
        
    }
    
    func getCurrentUser() -> User? {
        let authenticationProvider = LoginAccountRegistrationProvider()
        return authenticationProvider.getCurrentUser()
    }
    
}
