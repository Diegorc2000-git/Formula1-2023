//
//  AuthService.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 17/3/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class AuthService {
    static var storeRoot = Firestore.firestore()
    
    static func getUserId(userId: String) -> DocumentReference {
        return storeRoot.collection("users").document(userId)
    }
    
    static func signUp(email: String, password: String, name: String, surname: String, imageData: Data, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userId = authData?.user.uid else { return }
            guard let email = authData?.user.email else { return }

            let storageProfileUserId = AuthenticationFirebaseDatasource.storageProfileId(userId: userId)
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            //completionBlock(.success(.init(uid: "", email: email, profileImage: "", bio: "")))
            
            AuthenticationFirebaseDatasource.saveProfileImage(userId: userId,
                                                              email: email,
                                                              name: name,
                                                              surname: surname,
                                                              imageData: imageData,
                                                              metaData: metadata,
                                                              storageProfileImageRef: storageProfileUserId,
                                                              onSuccess: onSuccess,
                                                              onError: onError)
            
        }
    }
    
    static func signIn(email: String, password: String, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userId = authData?.user.uid else { return }
            
            let firestoreUserId = getUserId(userId: userId)
            
            firestoreUserId.getDocument { (document, error) in
                if let dict = document?.data() {
                    guard let decodedUser = try? User.init(fromDictionary: dict) else { return }
                    
                    onSuccess(decodedUser)
                }
            }
        }
    }
    
}

