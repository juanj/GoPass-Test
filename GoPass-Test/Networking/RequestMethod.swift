//
//  RequestMethod.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import Foundation

enum RequestMethod: String {
    case get
    case post

    var stringValue: String {
        self.rawValue.uppercased()
    }
}
