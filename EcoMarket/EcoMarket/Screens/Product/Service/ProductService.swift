//
//  ProductService.swift
//  EcoMarket
//
//  Created by Dinara on 04.05.2024.
//

import Alamofire
import Foundation

// MARK: - ProductServiceProtocol
protocol ProductServiceProtocol {
    func getProducts(completion: @escaping (Result<[Product], AFError>) -> Void)
}

// MARK: - ProductService Class
final class ProductService {}

// MARK: - Extension - ProductService
extension ProductService: ProductServiceProtocol {
    func getProducts(completion: @escaping (Result<[Product], AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "neobook.online"
        urlComponent.path = "/ecobak/product-list/"

        guard let url = urlComponent.url else {
            completion(.failure(.invalidURL(url: urlComponent)))
            return
        }

        AF.request(url, method: .get, headers: ["accept": "application/json"])
            .validate()
            .responseDecodable(of: [Product].self) { response in
                completion(response.result)
            }
    }
}
