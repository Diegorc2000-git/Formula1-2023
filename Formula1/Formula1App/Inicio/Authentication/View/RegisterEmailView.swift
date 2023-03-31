//
//  RegisterEmailView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 15/3/23.
//

import SwiftUI

struct RegisterEmailView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var sheetManager: SheetManager

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var profileImage: Image?
    @State private var pickerImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlertSuccess = false
    @State private var showingAlertFailure = false
    
    func loadImage() {
        guard let inputImage = pickerImage else { return }
        profileImage = inputImage
    }
    
    func errorCheck() -> String? {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if email.isEmpty || password.isEmpty || imageData.isEmpty || username.isEmpty {
            return LocalizedKeys.Errors.emailEmpty
        } else if password.count < 6 {
            return LocalizedKeys.Errors.passwordNotChar
        } else if emailPred.evaluate(with: email) == false {
            return LocalizedKeys.Errors.emailNotValid
        }
        return nil
    }
    
    func clear() {
        self.username = ""
        self.email = ""
        self.password = ""
        self.imageData = Data()
        self.profileImage = Image(ImageAndIconConstants.profileIcon)
    }
    
    func signUp() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlertFailure = true
            return
        }
        authenticationViewModel.createNewUserViewModel(username: username, email: email.lowercased(), password: password, imageData: imageData, onSuccess: { (user) in
            self.clear()
            self.showingAlertSuccess = true
        }) { (errorMessage) in
            print("_Error \(errorMessage)")
            self.error = errorMessage
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
            Group {
                Text(LocalizedKeys.SignUp.signupTitle)
                    .tint(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                if profileImage != nil {
                    profileImage!.resizable()
                        .frame(width: 150, height: 150)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                        .onTapGesture {
                            self.showingActionSheet.toggle()
                        }
                } else {
                    Image(ImageAndIconConstants.profileIcon)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                        .onTapGesture {
                            self.showingActionSheet.toggle()
                        }
                }
                VStack(spacing: 16) {
                    FormField(value: $username, placeHolder: LocalizedKeys.SignUp.surnameTextFieldSignup, isSecure: false)
                    FormField(value: $email, placeHolder: LocalizedKeys.SignUp.emailTextFieldSignup, isSecure: false)
                        .accessibilityIdentifier("usernameTextField")
                        .keyboardType(.emailAddress)
                    FormField(value: $password, placeHolder: LocalizedKeys.SignUp.passwordTextFieldSignup, isSecure: true)
                        .accessibilityIdentifier("passwordTextField")
                }
                Button(action: signUp) {
                    Text(LocalizedKeys.SignUp.signupButton)
                }
                .onChange(of: showingAlertFailure, perform: { newValue in
                    if newValue {
                        alertManager.popAlert(title: LocalizedKeys.Errors.errorTitle, subtitle: error, primaryActionTitle: LocalizedKeys.Generic.ok) {
                            alertManager.isPresented = false
                            showingAlertFailure = false
                        }
                    }
                })
                .onChange(of: showingAlertSuccess, perform: { newValue in
                    if newValue {
                        alertManager.popAlert(title: LocalizedKeys.SignUp.signunCompleted, subtitle: LocalizedKeys.SignUp.signUpSuccess,
                                              primaryActionTitle: LocalizedKeys.Generic.ok) {
                            alertManager.isPresented = false
                            sheetManager.isPresented = false
                            showingAlertSuccess = false
                        }
                    }
                })
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 150, height: 45)
                .background(Color.gray)
                .cornerRadius(12)
                .accessibilityIdentifier("signInButton")
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
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(pickerImage: self.$pickerImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text(LocalizedKeys.Generic.openGallery), buttons: [.default(Text(LocalizedKeys.SignUp.choosePhoto)) {
                self.sourceType = .photoLibrary
                self.showingImagePicker.toggle()
            },.cancel()])
        }
    }
}
