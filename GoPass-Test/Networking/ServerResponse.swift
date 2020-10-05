//
//  ServerResponse.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import Foundation

struct ServerResponse<T: Codable> {
    let hasData: Bool
    let code: Int
    let status: Int
    let data: T?
}

extension ServerResponse: Codable {
    enum CodingKeys : String, CodingKey {
        case hasData = "return"
        case code
        case status
        case data
    }
}
