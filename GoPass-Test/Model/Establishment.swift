//
//  Establishment.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import Foundation

struct Establishment {
    let name: String
    let address: String
    let imageurl: String?
    let schedule: String?
    let latitud: String?
    let longitud: String?
}

extension Establishment: Codable {
    enum CodingKeys : String, CodingKey {
        case name = "nombre"
        case address = "direccion"
        case imageurl
        case schedule = "horario"
        case latitud
        case longitud
    }
}
