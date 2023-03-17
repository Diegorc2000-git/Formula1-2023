//
//  AuthenticationViewModel.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 15/3/23.
//

import Foundation

final class AuthenticationViewModel: ObservableObject {
    @Published var user: User?
    @Published var messageError: String?
    @Published var showAlert: Bool = false
    @Published var isAccountLinked: Bool = false
    @Published var linkedAccounts: [LinkedAccounts] = []
    private let service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
        getCurrentUser()
    }
    
    func getCurrentUser() {
        self.user = service.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if email.isEmpty || password.isEmpty {
            self.messageError = "Rellena los campos obligatorios"
        } else if password.count < 6 {
            self.messageError = "La contraseña tiene que ser de al menos 6 digitos"
        } else if emailPred.evaluate(with: email) == false {
            self.messageError = "El email introducido es incorrecto, ejemplo@gmail.com"
        } else {
            service.createNewUser(email: email,
                                  password: password) { [weak self] result in
                switch result {
                case .success(let user):
                    self?.user = user
                case .failure( _):
                    self?.messageError = "Usuario ya registrado"
                }
            }
        }
    }
    
    func login(email: String, password: String) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if email.isEmpty || password.isEmpty {
            self.messageError = "Rellena los campos obligatorios"
        } else if password.count < 6 {
            self.messageError = "La contraseña tiene que ser de al menos 6 digitos"
        } else if emailPred.evaluate(with: email) == false {
            self.messageError = "El email introducido es incorrecto, ejemplo@gmail.com"
        } else {
            service.login(email: email,
                          password: password) { [weak self] result in
                switch result {
                case .success(let user):
                    self?.user = user
                case .failure(_):
                    self?.messageError = "Usuario o contraseña incorrecta"
                }
            }
        }
    }
    
    func logout() {
        do {
            try service.logout()
            self.user = nil
        } catch {
            print("Error logout")
        }
    }
    
    func getCurrentProvider() {
        linkedAccounts = service.getCurrentProvider()
        print("User Provider \(linkedAccounts)")
    }
    
    func isEmailAndPasswordLinked() -> Bool {
        linkedAccounts.contains(where: { $0.rawValue == "password" })
    }
    
    func linkEmailAndPassword(email: String, password: String) {
        service.linkEmailAndPassword(email: email,
                                     password: password) { [weak self] isSuccess in
            print("Linked Email and Password \(isSuccess.description)")
            self?.isAccountLinked = isSuccess
            self?.showAlert.toggle()
            self?.getCurrentProvider()
        }
    }
    
    func isFacebookLinked() -> Bool {
        linkedAccounts.contains(where: { $0.rawValue == "facebook.com" })
    }
    
    func linkFacebook() {
        service.linkFacebook { [weak self] isSuccess in
            print("Linked Facebook \(isSuccess.description)")
            self?.isAccountLinked = isSuccess
            self?.showAlert.toggle()
            self?.getCurrentProvider()
        }
    }
    
    func loginFacebook() {
        service.loginFacebook() { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
}
