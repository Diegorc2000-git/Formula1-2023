//
//  EditProfileContentView.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 21/3/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct EditProfileContentView: View {
    @ObservedObject var profileViewModel: AuthenticationViewModel
    @EnvironmentObject var session: SessionStore
    @State private var username: String = ""
    @State private var bio: String = ""
    @State private var profileImage: Image?
    @State private var pickerImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = LocalizedKeys.Errors.errorTitle
    @State private var alertTitleSuccess: String = "_Registro Completado"
    
    init(session: User?, profileViewModel: AuthenticationViewModel) {
        _bio = State(initialValue: session?.bio ?? "")
        _username = State(initialValue: session?.username ?? "")
        self.profileViewModel = profileViewModel
    }
    
    func loadImage() {
        guard let inputImage = pickerImage else { return }
        
        profileImage = inputImage
    }
    
    func errorCheck() -> String? {
        if username.trimmingCharacters(in: .whitespaces).isEmpty ||
            bio.trimmingCharacters(in: .whitespaces).isEmpty ||
            imageData.isEmpty {
            
            return "_Rellena todos los campos"
        }
        return nil
    }
    
    func clear() {
        self.bio = ""
        self.username = ""
        self.imageData = Data()
        self.profileImage = Image(systemName: "person.circle.fill")
    }
    
    func edit() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        profileViewModel.editProfile(imageData: imageData, username: username, bio: bio, onSuccess: { (user) in
            self.clear()
        }) { (errorMessage) in
            print("_Error \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
        self.clear()
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("_Edit Profile").font(.largeTitle)
                
                VStack {
                    Group {
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
                            WebImage(url: URL(string: session.session!.profileImageUrl)!)
                                .resizable()
                                .frame(width: 150, height: 150)
                                .padding(.top, 20)
                                .padding(.bottom, 40)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                        }
                    }
                }
            }
            
            TextField(LocalizedKeys.Profile.editProfileName, text: $username)
                .modifier(TextFieldModifiers())
                .accessibilityIdentifier("nameTextField")
            TextField(LocalizedKeys.Profile.editProfileBio, text: $bio)
                .modifier(TextFieldModifiers())
                .accessibilityIdentifier("bioTextField")
            
            Button(action: edit) {
                Text(LocalizedKeys.Profile.editButton).font(.title).modifier(ButtonModifiers())
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text(LocalizedKeys.Generic.ok)))
            }
            
            Text(LocalizedKeys.Profile.editSubtitle)
                .padding()
            
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(pickerImage: self.$pickerImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
        }.actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Abrir Galeria"), buttons: [.default(Text(LocalizedKeys.SignUp.choosePhoto)) {
                self.sourceType = .photoLibrary
                self.showingImagePicker = true
            },.cancel()])
        }
    }
}
