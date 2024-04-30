//
//  Fonts.swift
//  EcoMarket
//
//  Created by Dinara on 30.04.2024.
//

import UIKit

protocol FontsProtocol {
    var rawValue: String { get }
}

enum Fonts: String, FontsProtocol {
    case regular = "TTNormsPro-Regular"
    case medium = "TTNormsPro-Medium"
    case semibold = "TTNormsPro-Bold"
}

extension FontsProtocol {
    private func apply(size value: CGFloat) -> UIFont {
        guard let font = UIFont.init(name: rawValue, size: value) else {
            fatalError("Could not find font with name \(rawValue)")
        }
        return font
    }
}

extension FontsProtocol {
    func s10() -> UIFont {
        return apply(size: 10)
    }

    func s12() -> UIFont {
        return apply(size: 12)
    }

    func s14() -> UIFont {
        return apply(size: 14)
    }

    func s16() -> UIFont {
        return apply(size: 16)
    }

    func s18() -> UIFont {
        return apply(size: 18)
    }

    func s20() -> UIFont {
        return apply(size: 20)
    }

    func s22() -> UIFont {
        return apply(size: 22)
    }

    func s24() -> UIFont {
        return apply(size: 24)
    }
}

