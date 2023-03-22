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
    @State var name: String = ""
    @State var surname: String = ""
    @State var profileImage: Image?
    @State var pickerImage: Image?
    @State var showingActionSheet = false
    @State var showingImagePicker = false
    @State var imageData: Data = Data()
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var error: String = ""
    @State var showingAlert = false
    @State var alertTitle: String = "¡Ha ocurrido un error!"
    
    func loadImage() {
        guard let inputImage = pickerImage else { return }
        profileImage = inputImage
    }
    
    func errorCheck() -> String? {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if email.isEmpty || password.isEmpty || imageData.isEmpty {
            return "Rellena los campos obligatorios y añade una imagen de perfil"
        } else if password.count < 6 {
            return "La contraseña tiene que ser de al menos 6 digitos"
        } else if emailPred.evaluate(with: email) == false {
            return "El email introducido es incorrecto, ejemplo@gmail.com"
        }
        return nil
    }
    
    func clear() {
        self.email = ""
        self.password = ""
    }
    
    func signUp() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        AuthService.signUp(email: email, password: password, name: name, surname: surname, imageData: imageData, onSuccess: { (user) in
            self.clear()
        }) { (errorMessage) in
            print("Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
        //authenticationViewModel.createNewUser(email: textFieldEmail, password: textFieldPassword, imageData: imageData)
    }
    
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
            Group {
                Text("Regístrate para poder acceder a la app.")
                    .tint(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                if profileImage != nil {
                    profileImage!.resizable()
                        .clipShape(Circle())
                        .frame(width: 150, height: 150)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                } else {
                    Image("icon_profile_image")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                }
                VStack(spacing: 32) {
                    TextField("Introduce tu correo electrónico", text: $email)
                        .accessibilityIdentifier("usernameTextField")
                    SecureField("Introduce tu contraseña", text: $password)
                        .accessibilityIdentifier("passwordTextField")
                }
                .padding()
                .background(.gray.opacity(0.2))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .keyboardType(.emailAddress)
                Button(action: signUp) {
                    Text("Aceptar")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 100, height: 45)
                .background(Color.gray)
                .cornerRadius(12)
                .accessibilityIdentifier("signInButton")
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                }
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
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(pickerImage: self.$pickerImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text(""), buttons: [.default(Text("Choose a photo")) {
                self.sourceType = .photoLibrary
                self.showingImagePicker = true
            },.default(Text("Take a photo")) {
                self.sourceType = .camera
                self.showingImagePicker = true
            }, .cancel()])
        }
    }
}

struct RegisterEmailView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEmailView(authenticationViewModel: AuthenticationViewModel(service: NetworkServiceFactory.create()))
    }
}
