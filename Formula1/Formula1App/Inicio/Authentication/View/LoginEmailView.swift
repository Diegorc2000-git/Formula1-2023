//
//  LoginEmailView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 15/3/23.
//

import SwiftUI

struct LoginEmailView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var sheetManager: SheetManager
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @State private var showingAlertFailure = false
    
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
            self.showingAlertFailure = true
            return
        }
        authenticationViewModel.login(email: email.lowercased(), password: password, onSuccess: { (user) in
            self.clear()
        }) { errorMessage in
            print("_Error \(errorMessage)")
            self.error = "Usuario no registrado"
            self.showingAlertFailure = true
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
            Image(ImageAndIconConstants.racingCarIcon)
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
                FormField(value: $email, placeHolder: LocalizedKeys.SignIn.emailTextFieldLogin, isSecure: false)
                    .accessibilityIdentifier("usernameTextField")
                FormField(value: $password, placeHolder: LocalizedKeys.SignIn.passwordTextFieldLogin, isSecure: true)
                    .accessibilityIdentifier("passwordTextField")
                Button(action: signIn) {
                    Text(LocalizedKeys.SignIn.loginButtonTitle)
                }
                .onChange(of: showingAlertFailure, perform: { newValue in
                    if newValue {
                        alertManager.popAlert(title: LocalizedKeys.Errors.errorTitle, subtitle: error, primaryActionTitle: LocalizedKeys.Generic.ok) {
                            alertManager.isPresented = false
                            showingAlertFailure = false
                        }
                    }
                })
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 150, height: 45)
                .background(Color.gray)
                .cornerRadius(12)
                .accessibilityIdentifier("loginButton")
                Text(LocalizedKeys.Generic.requiredFields)
                    .padding(.horizontal, 8)
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .foregroundColor(.gray.opacity(0.5))
            }
            .padding(.horizontal, 32)
            Spacer()
        }
        .accentColor(.black)
        .preferredColorScheme(.light)
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
