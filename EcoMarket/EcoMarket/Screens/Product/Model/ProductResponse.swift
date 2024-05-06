//
//  ProductResponse.swift
//  EcoMarket
//
//  Created by Dinara on 04.05.2024.
//

import Foundation

struct ProductsResponse: Codable {
    let page: Int
    let count: Int?
    let next: String
    let previous: String?
    let results: [Product]
}
