//
//  ServerError.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import Foundation

struct ServerError: Error, LocalizedError {
    let message: String

    var errorDescription: String? { message }
}

extension ServerError: Codable {
    enum CodingKeys : String, CodingKey {
        case message = "mensaje"
    }
}
