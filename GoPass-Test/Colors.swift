//
//  Colors.swift
//  GoPass-Test
//
//  Created by Juan on 5/10/20.
//

import UIKit

extension UIColor {
    private static func getColorOrFail(name: String) -> UIColor {
        guard let color = UIColor(named: name) else {
            fatalError("Can't load color \(name)")
        }
        return color
    }

    static let neonGreen = getColorOrFail(name: "NeonGreen")
}
