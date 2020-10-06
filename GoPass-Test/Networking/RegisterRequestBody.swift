//
//  RegisterRequestBody.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import Foundation

struct RegisterRequestBody {
    let documentType: String
    let documentNumber: String
    let name: String
    let lastName: String
    let phoneNumber: String
    let email: String
    let password: String
}

extension RegisterRequestBody: Codable {
    enum CodingKeys : String, CodingKey {
        case documentType = "tipoDocumento"
        case documentNumber = "numeroIdentificacion"
        case name = "nombres"
        case lastName = "apellidos"
        case phoneNumber = "telefonoMovil"
        case email = "correo"
        case password
    }
}
