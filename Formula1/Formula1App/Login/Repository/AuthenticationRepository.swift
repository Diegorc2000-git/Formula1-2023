//
//  AuthenticationRepository.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 15/3/23.
//

import Foundation
import Firebase
import FirebaseStorage

protocol NetworkService {
    func signIn(email: String, password: String, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void)
    func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void)
    func logout() throws
    func getCurrentUser() -> User?
    func editProfile(username: String, bio: String, imageData: Data, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void)
}

class AuthenticationRepository: NetworkService {
    private let authenticationProvider: LoginAccountRegistrationProvider
    @Published var messageError: String?
    
    init(authenticationProvider: LoginAccountRegistrationProvider = LoginAccountRegistrationProvider()) {
        self.authenticationProvider = authenticationProvider
    }
    
    func getCurrentUser() -> User? {
        authenticationProvider.getCurrentUser()
    }
    
    func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        authenticationProvider.signUp(username: username, email: email, password: password, imageData: imageData, onSuccess: onSuccess, onError: onError)
    }

    func signIn(email: String, password: String, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        authenticationProvider.signIn(email: email, password: password, onSuccess: onSuccess, onError: onError)
    }
    
    func logout() throws {
        try authenticationProvider.logout()
    }
    
    func editProfile(username: String, bio: String, imageData: Data, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {

        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let storageProfileUserId = LoginAccountRegistrationProvider.storageProfileId(userId: userId)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        authenticationProvider.editProfile(userId: userId, username: username, bio: bio, imageData: imageData, metaData: metadata, storageProfileImageRef: storageProfileUserId, onError: onError)
        
    }
}
