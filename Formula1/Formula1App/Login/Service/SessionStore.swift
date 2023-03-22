//
//  SessionStore.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 21/3/23.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth

class SessionStore: ObservableObject {
    
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? { didSet { self.didChange.send(self)} }
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            
            if let user = user {
                
                let firestoreUserId = AuthService.getUserId(userId: user.uid)
                firestoreUserId.getDocument { (document, error) in
                    if let dict = document?.data() {
                        guard let decodedUser = try? User.init(fromDictionary: dict) else { return }
                        self.session = decodedUser
                    }
                }
            } else {
                self.session = nil
            }
        })
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
    
}
