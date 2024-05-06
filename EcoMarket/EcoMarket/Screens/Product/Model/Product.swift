//
//  Product.swift
//  EcoMarket
//
//  Created by Dinara on 02.05.2024.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let category: Int
    let image: String
    let quantity: Int
    let price: String
}
