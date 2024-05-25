//
//  Colors.swift
//  EcoMarket
//
//  Created by Dinara on 30.04.2024.
//

import UIKit

protocol ColorsProtocol {
    var rawValue: String { get }
}

extension ColorsProtocol {
    var uiColor: UIColor {
        UIColor(hex: rawValue) ?? .black
    }

    var cgColor: CGColor {
        return uiColor.cgColor
    }
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

enum Colors: String, ColorsProtocol {
    case black = "1F1F1F"
    case gray = "D2D1D5"
    case green = "75DB1B"
    case lightGray = "F8F8F8"
    case white = "FFFFFF"
    case red = "ED2929"
}
