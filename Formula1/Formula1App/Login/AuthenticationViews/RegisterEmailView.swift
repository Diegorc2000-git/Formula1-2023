//
//  RegisterEmailView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 15/3/23.
//

import SwiftUI

struct RegisterEmailView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var textFieldEmail: String = ""
    @State var textFieldPassword: String = ""
    
    var body: some View {
        VStack {
            DismissView()
                .padding(.top, 8)
            
            Text("Formula1")
                .bold()
                .underline()
                .padding(.horizontal, 8)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .tint(.primary)
            
            Image("icon_lights")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                .padding(.bottom)
            
            Group {
                
                Text("Regístrate para poder acceder a la app.")
                    .tint(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                
                TextField("Introduce tu correo electrónico", text: $textFieldEmail)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .keyboardType(.emailAddress)
                    .accessibilityIdentifier("usernameTextField")
                
                TextField("Introduce tu contraseña", text: $textFieldPassword)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .keyboardType(.emailAddress)
                    .accessibilityIdentifier("passwordTextField")
                
                Button("Aceptar") {
                    authenticationViewModel.createNewUser(email: textFieldEmail,
                                                          password: textFieldPassword)
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 100, height: 45)
                .background(Color.gray)
                .cornerRadius(12)
                .accessibilityIdentifier("signInButton")
                
                Text("* campos obligatorios")
                    .padding(.horizontal, 8)
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .foregroundColor(.gray.opacity(0.5))
                
                if let messageError = authenticationViewModel.messageError {
                    Text(messageError)
                        .bold()
                        .font(.body)
                        .foregroundColor(.red)
                        .padding(.top, 20)
                        .accessibilityIdentifier("messageText")
                }
            }
            .padding(.horizontal, 32)
            Spacer()
        }
    }
}
