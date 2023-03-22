//
//  EditProfileContentView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 21/3/23.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct EditProfileContentView: View {
    @EnvironmentObject var session: SessionStore
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var profileImage: Image?
    @State private var pickerImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "¡Ha ocurrido un error!"
    @State private var bio: String
    
    init(session: User?) {
        _bio = State(initialValue: session?.bio ?? "")
        _name = State(initialValue: session?.name ?? "")
        _surname = State(initialValue: session?.surname ?? "")
    }
    
    func loadImage() {
        guard let inputImage = pickerImage else { return }
        
        profileImage = inputImage
    }
    
    func errorCheck() -> String? {
        if surname.trimmingCharacters(in: .whitespaces).isEmpty ||
            bio.trimmingCharacters(in: .whitespaces).isEmpty ||
            name.trimmingCharacters(in: .whitespaces).isEmpty {
            
            return "Rellena todos los campos"
        }
        return nil
    }
    
    func clear() {
        self.bio = ""
        self.name = ""
        self.surname = ""
        self.imageData = Data()
        self.profileImage = Image(systemName: "person.circle.fill")
    }
    
    func edit() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let storageProfileUserId = AuthenticationFirebaseDatasource.storageProfileId(userId: userId)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        AuthenticationFirebaseDatasource.editProfile(userId: userId, name: name, surname: surname, bio: bio, imageData: imageData, metaData: metadata, storageProfileImageRef: storageProfileUserId, onError: { (errorMessage) in
            self.error = errorMessage
            self.showingAlert = true
            return
        })
        self.clear()
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                
                Text("Editar Perfil")
                    .font(.largeTitle)
                
                VStack {
                    Group {
                        if profileImage != nil {
                            profileImage!.resizable()
                                .frame(width: 200, height: 200)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                        } else {
                            WebImage(url: URL(string: session.session?.profileImage ?? ""))
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 100, height: 100)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                        }
                    }
                }
                TextField("Introduce tu Nombre*", text: $name)
                    .modifier(TextFieldModifiers())
                    .accessibilityIdentifier("nameTextField")
                TextField("Introduce tus Apellidos*", text: $surname)
                    .modifier(TextFieldModifiers())
                    .accessibilityIdentifier("surnameTextField")
                TextField("Introduce tu Biografia*", text: $bio)
                    .modifier(TextFieldModifiers())
                    .accessibilityIdentifier("bioTextField")
                Button(action: edit) {
                    Text("Edit").font(.title).modifier(ButtonModifiers())
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("OK")))
                }
                
                Text("Los cambios se aplicaran la proxima vez que hagas login")
                    .padding()
            }
        }.navigationTitle(session.session?.name ?? "")
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
