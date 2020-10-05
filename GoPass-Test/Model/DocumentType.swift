//
//  DocumentType.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import Foundation

struct DocumentType {
    let id: String
    let name: String

    func abreviated() -> String {
        return name.split(separator: " ")
            .compactMap(\.first)
            .map { $0.uppercased() }
            .joined(separator: ".")
    }
}

extension DocumentType: Codable {
    enum CodingKeys : String, CodingKey {
        case id
        case name = "tipo"
    }
}
