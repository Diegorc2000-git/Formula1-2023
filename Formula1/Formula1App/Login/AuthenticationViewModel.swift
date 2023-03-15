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
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository = AuthenticationRepository()) {
        self.authenticationRepository = authenticationRepository
        getCurrentUser()
    }
    
    func getCurrentUser() {
        self.user = authenticationRepository.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String) {
        if email.isEmpty || password.isEmpty {
            self.messageError = "Rellena los campos obligatorios"
        } else {
            authenticationRepository.createNewUser(email: email,
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
        if email.isEmpty || password.isEmpty {
            self.messageError = "Rellena los campos obligatorios"
        } else {
            authenticationRepository.login(email: email,
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
            try authenticationRepository.logout()
            self.user = nil
        } catch {
            print("Error logout")
        }
    }
    
}
