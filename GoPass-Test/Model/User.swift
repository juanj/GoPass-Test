//
//  User.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import Foundation

struct User {
    let uid: String
    let name: String
    let lastName: String
    let email: String
    let phoneNumber: String
}

extension User: Codable {
    enum CodingKeys : String, CodingKey {
        case uid
        case name = "nombres"
        case lastName = "apellidos"
        case email = "correo"
        case phoneNumber = "telefono"
    }
}
