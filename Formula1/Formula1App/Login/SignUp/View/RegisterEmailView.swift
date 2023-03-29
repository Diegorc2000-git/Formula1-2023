//
//  RegisterEmailView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 15/3/23.
//

import SwiftUI

struct RegisterEmailView: View {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    @State var email: String = ""
    @State var password: String = ""
    @State var username: String = ""
    @State var profileImage: Image?
    @State var pickerImage: Image?
    @State var showingActionSheet = false
    @State var showingImagePicker = false
    @State var imageData: Data = Data()
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var error: String = ""
    @State var showingAlert = false
    @State var showingAlertSuccess = false
    @State var alertTitle: String = LocalizedKeys.Errors.errorTitle
    @State var alertTitleSuccess: String = "_Registro Completado"
    
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
        self.profileImage = Image("icon_profile_image")
    }
    
    func signUp() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert.toggle()
            return
        }
        authenticationViewModel.createNewUserViewModel(username: username, email: email.lowercased(), password: password, imageData: imageData, onSuccess: { (user) in
            self.clear()
            self.showingAlertSuccess.toggle()
        }) { (errorMessage) in
            print("_Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert.toggle()
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
                    Image("icon_profile_image")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                        .onTapGesture {
                            self.showingActionSheet.toggle()
                        }
                }
                VStack(spacing: 32) {
                    TextField("_Introduce tu nombre de usuario*", text: $username)
                    TextField(LocalizedKeys.SignUp.emailTextFieldSignup, text: $email)
                        .accessibilityIdentifier("usernameTextField")
                    SecureField(LocalizedKeys.SignUp.passwordTextFieldSignup, text: $password)
                        .accessibilityIdentifier("passwordTextField")
                }
                .padding()
                .background(.gray.opacity(0.2))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .keyboardType(.emailAddress)
                Button(action: signUp) {
                    Text(LocalizedKeys.SignUp.signupButton)
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 150, height: 45)
                .background(Color.gray)
                .cornerRadius(12)
                .accessibilityIdentifier("signInButton")
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitleSuccess), message: Text("_Cuenta creada correctamente, Inicia Sesión"), dismissButton: .default(Text(LocalizedKeys.Generic.ok)))
                }
                .alert(isPresented: $showingAlertSuccess) {
                    Alert(title: Text(alertTitleSuccess), message: Text("_Cuenta creada correctamente, Inicia Sesión"), dismissButton: .default(Text(LocalizedKeys.Generic.ok)))
                }
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
            ActionSheet(title: Text("_Galeria"), buttons: [.default(Text(LocalizedKeys.SignUp.choosePhoto)) {
                self.sourceType = .photoLibrary
                self.showingImagePicker.toggle()
            },.cancel()])
        }
    }
}

struct RegisterEmailView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEmailView(authenticationViewModel: AuthenticationViewModel(service: NetworkServiceFactory.create()))
    }
}
