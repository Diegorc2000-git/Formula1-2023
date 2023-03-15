////
////  MockWebService.swift
////  MockingLoginUI
////
////  Created by Diego Rodriguez Casillas on 14/3/23.
////
//
//import Foundation
//import Firebase
//
//class MockWebservice: NetworkService {
//
//    func getCurrentUser() -> User? {
//        guard let email = Auth.auth().currentUser?.email else {
//            return nil
//        }
//        return .init(email: email)
//    }
//
//    func logOut() throws {
//
//    }
//    
//    func login(username: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
//
//        if username == "Diegorc2000@icloud.com" && password == "123456" {
//            completion(.success(()))
//        } else {
//            completion(.failure(.notAuthenticated))
//        }
//    }
//
//    func signIn(username: String, password: String, completion: @escaping (Result<Void, NetworkError>) -> Void) {
//
//        if username == "Drodcasi@nttdata.com" && password == "rH4H3W2W5r" {
//            completion(.success(()))
//        } else {
//            completion(.failure(.badRequest))
//        }
//    }
//
//}
