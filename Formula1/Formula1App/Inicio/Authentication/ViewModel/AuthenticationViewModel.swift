//
//  AuthenticationViewModel.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 15/3/23.
//

import Foundation
import FirebaseAuth

final class AuthenticationViewModel: ObservableObject {
    @Published var user: User?
    private let service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
        getCurrentUser()
    }
    
    func getCurrentUser() {
        self.user = service.getCurrentUser()
    }
    
    func createNewUserViewModel(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        service.signUp(username: username, email: email, password: password, imageData: imageData, onSuccess: onSuccess, onError: onError)
    }
    
    func login(email: String, password: String, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        service.signIn(email: email, password: password, onSuccess: onSuccess, onError: onError)
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.user = nil
        } catch {
            print("_Error logout")
        }
    }
    
    func editProfile(imageData: Data, username: String, bio: String, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        service.editProfile(username: username, bio: bio, imageData: imageData, onSuccess: onSuccess, onError: onError)
    }
}
