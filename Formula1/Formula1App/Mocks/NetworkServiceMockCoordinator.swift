//
//  NetworkServiceMockCoordinator.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 16/3/23.
//

import Foundation

class NetworkServiceMockCoordinator {
    
    static func create() -> NetworkService {
        
        let environment = ProcessInfo.processInfo.environment["ENV"]
        
        if let environment = environment {
            if environment == "TEST" {
                return LoginMock()
            } else {
                return AuthenticationRepository()
            }
        } else {
            return AuthenticationRepository()
        }

    }
    
}
