//
//  User.swift
//  Formula1
//
//  Created by Diego Rodriguez Casillas on 15/3/23.
//

import Foundation

struct User: Encodable, Decodable {
    let uid: String
    let email: String
    let profileImage: String
    let bio: String
    let name: String
    let surname: String
}
