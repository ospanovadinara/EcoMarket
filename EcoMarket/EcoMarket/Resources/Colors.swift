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

enum Colors: String, ColorsProtocol {
    case black = "1F1F1F"
    case gray = "D2D1D5"
    case green = "75DB1B"
    case lightGray = "F8F8F8"
    case white = "FFFFFF"
}


extension ColorsProtocol {
    var uiColor: UIColor {
        UIColor.init(named: rawValue) ?? .black
    }

    var cgColor: CGColor {
        return uiColor.cgColor
    }
}

