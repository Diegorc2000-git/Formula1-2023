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
    @Published var messageError: String?
    @Published var showAlert: Bool = false
    private let service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
        getCurrentUser()
    }
    
    func getCurrentUser() {
        self.user = service.getCurrentUser()
    }
    
    func createNewUserViewModel(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if email.isEmpty || password.isEmpty {
            self.messageError = "Rellena los campos obligatorios"
        } else if password.count < 6 {
            self.messageError = "La contraseña tiene que ser de al menos 6 digitos"
        } else if emailPred.evaluate(with: email) == false {
            self.messageError = "El email introducido es incorrecto, ejemplo@gmail.com"
        } else {
            service.signUp(username: username, email: email, password: password, imageData: imageData, onSuccess: onSuccess, onError: onError)
        }
    }
    
    func login(email: String, password: String, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if email.isEmpty || password.isEmpty {
            self.messageError = LocalizedKeys.Errors.emailEmpty
        } else if password.count < 6 {
            self.messageError = LocalizedKeys.Errors.passwordNotChar
        } else if emailPred.evaluate(with: email) == false {
            self.messageError = LocalizedKeys.Errors.emailNotValid
        } else {
            service.signIn(email: email, password: password, onSuccess: onSuccess, onError: onError)
        }
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
