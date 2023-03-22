//
//  AuthenticationDataSource.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 15/3/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

final class AuthenticationFirebaseDatasource {
    
    private let facebookAuthentication = FacebookAuthentication()
    static var storage = Storage.storage()
    static var storageRoot = storage.reference()
    static var storageProfile = storageRoot.child("profile")
    
    static func storageProfileId(userId: String) -> StorageReference {
        return storageProfile.child(userId)
    }
    
    static func editProfile(userId: String, name: String, surname: String, bio: String, imageData: Data, metaData: StorageMetadata, storageProfileImageRef: StorageReference, onError: @escaping(_ errorMessage: String) -> Void) {
     
        storageProfileImageRef.putData(imageData, metadata: metaData) { (StorageMetadata, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            storageProfileImageRef.downloadURL { (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    
                    if let changeRequest =
                        Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.commitChanges { error in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                        }
                    }
                    let firestoreUserId = AuthService.getUserId(userId: userId)
                    
                    firestoreUserId.updateData([
                        "profileImageUrl": metaImageUrl,
                        "bio": bio,
                        "name": name,
                        "surname": surname
                    ])
                }
            }
        }
        
    }
    
    static func saveProfileImage(userId: String, email: String, name: String, surname: String, imageData: Data, metaData: StorageMetadata, storageProfileImageRef: StorageReference, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        storageProfileImageRef.putData(imageData, metadata: metaData) { (StorageMetadata, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            storageProfileImageRef.downloadURL { (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.commitChanges { (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                        }
                    }
                    let firestoreUserId = AuthService.getUserId(userId: userId)
                    let user = User.init(uid: userId, email: email, profileImage: metaImageUrl, bio: "", name: "", surname: "")
                    guard let dict = try? user.asDictionary() else { return }
                    firestoreUserId.setData(dict) { (error) in
                        if error != nil {
                            onError(error!.localizedDescription)
                        }
                    }
                    onSuccess(user)
                }
            }
        }
    }
    
    func getCurrentUser() -> User? {
        guard let email = Auth.auth().currentUser?.email else {
            return nil
        }
        return .init(User(uid: "", email: email, profileImage: "", bio: "", name: "", surname: ""))
    }
    
    func createNewUser(email: String, password: String, name: String, surname: String, imageData: Data, completionBlock: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                print("Error creating a new user \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = authDataResult?.user.email ?? "No email"
            print("New user created with info \(email)")
            completionBlock(.success(.init(uid: "", email: email, profileImage: "", bio: "", name: "", surname: "")))
        }
    }
    
    func login(email: String, password: String, name: String, surname: String, completionBlock: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                print("Error login user \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            let email = authDataResult?.user.email ?? "No email"
            print("User login with info \(email)")
            completionBlock(.success(.init(uid: "", email: email, profileImage: "", bio: "", name: "", surname: "")))
        }
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    func getCurrentCredential() -> AuthCredential? {
        guard let providerId = currentProvider().last else {
            return nil
        }
        switch providerId {
        case .facebook:
            guard let accessToken = facebookAuthentication.getAccessToken() else {
                return nil
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
            return credential
        case .emailAndPassword, .unknown:
            return nil
        }
    }
    
    func currentProvider() -> [LinkedAccounts] {
        guard let currentUser = Auth.auth().currentUser else {
            return []
        }
        let linkedAccounts = currentUser.providerData.map { userInfo in
            LinkedAccounts(rawValue: userInfo.providerID)
        }.compactMap { $0 }
        return linkedAccounts
    }
    
    func linkEmailAndPassword(email: String, password: String, completionBlock: @escaping(Bool) -> Void) {
        guard let credential = getCurrentCredential() else {
            print("Error Creating Credential")
            completionBlock(false)
            return
        }
        
        Auth.auth().currentUser?.reauthenticate(with: credential,
                                                completion: { authDataResult, error in
            if let error = error {
                print("Error reauthenticating a user \(error.localizedDescription)")
                completionBlock(false)
                return
            }
            
            let emailAndPasswordCredential = EmailAuthProvider.credential(withEmail: email,
                                                                          password: password)
            
            Auth.auth().currentUser?.link(with: emailAndPasswordCredential,
                                          completion: { authDataResult, error in
                if let error = error {
                    print("Error linking a new user \(error.localizedDescription)")
                    completionBlock(false)
                    return
                }
                let email = authDataResult?.user.email ?? "No email"
                print("New user linked with email \(email)")
                completionBlock(true)
            })
        })
    }
    
    func loginWithFacebook(completionBlock: @escaping (Result<User, Error>) -> Void) {
        facebookAuthentication.loginFacebook { result in
            switch result {
            case .success(let accessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
                Auth.auth().signIn(with: credential) { authDataResult, error in
                    if let error = error {
                        print("Error creating a new user \(error.localizedDescription)")
                        completionBlock(.failure(error))
                        return
                    }
                    let email = authDataResult?.user.email ?? "No email"
                    print("New user created with info \(email)")
                    completionBlock(.success(.init(uid: "", email: email, profileImage: "", bio: "", name: "", surname: "")))
                }
            case .failure(let error):
                print("Error signIn with Facebook \(error.localizedDescription)")
                completionBlock(.failure(error))
            }
        }
    }
    
    func linkFacebook(completionBlock: @escaping (Bool) -> Void) {
        facebookAuthentication.loginFacebook { result in
            switch result {
            case .success(let accessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
                Auth.auth().currentUser?.link(with: credential, completion: { authDataResult, error in
                    if let error = error {
                        print("Error linking a new user \(error.localizedDescription)")
                        completionBlock(false)
                        return
                    }
                    let email = authDataResult?.user.email ?? "No email"
                    print("New user linked with email \(email)")
                    completionBlock(true)
                })
            case .failure(let error):
                print("Error linking a new user \(error.localizedDescription)")
                completionBlock(false)
            }
        }
    }
}
