//
//  loginEmailView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 15/3/23.
//

import SwiftUI

struct LoginEmailView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var email: String = ""
    @State var password: String = ""
    
    @State var error: String = ""
    @State var showingAlert = false
    @State var alertTitle: String = LocalizedKeys.Errors.errorTitle
    
    func errorCheck() -> String? {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if email.isEmpty || password.isEmpty {
            return LocalizedKeys.Errors.emailEmpty
        } else if password.count < 6 {
            return LocalizedKeys.Errors.passwordNotChar
        } else if emailPred.evaluate(with: email) == false {
            return LocalizedKeys.Errors.emailNotValid
        }
        return nil
    }
    
    func clear() {
        self.email = ""
        self.password = ""
    }
    
    func signIn() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        AuthService.signIn(email: email, password: password, onSuccess: { (user) in
            self.clear()
        }) { errorMessage in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }
    
    var body: some View {
        VStack {
            DismissView()
                .padding(.top, 8)
            Text(LocalizedKeys.App.appName)
                .bold()
                .underline()
                .padding(.horizontal, 8)
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .tint(.primary)
            Image("icon_racing_car")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                .padding(.bottom)
            Group {
                Text(LocalizedKeys.SignIn.loginTitle)
                    .tint(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                TextField(LocalizedKeys.SignIn.emailTextFieldLogin, text: $email)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .keyboardType(.emailAddress)
                    .accessibilityIdentifier("usernameTextField")
                SecureField(LocalizedKeys.SignIn.passwordTextFieldLogin, text: $password)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                    .keyboardType(.emailAddress)
                    .accessibilityIdentifier("passwordTextField")
                Button(action: signIn) {
                    Text(LocalizedKeys.SignIn.loginButtonTitle)
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 100, height: 45)
                .background(Color.gray)
                .cornerRadius(12)
                .accessibilityIdentifier("loginButton")
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text(LocalizedKeys.Generic.ok)))
                }
                Text(LocalizedKeys.Generic.requiredFields)
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

struct DismissView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
            })
            .tint(.black)
            .padding(.trailing, 12)
        }
        .buttonStyle(.bordered)
    }
}
