//
//  NetworkService.swift
//  EcoMarket
//
//  Created by Dinara on 02.05.2024.
//
import Alamofire
import Foundation

// MARK: - ProductCategoryServiceProtocol
protocol ProductCategoryServiceProtocol {
    func getCategories(completion: @escaping (Result<[ProductCategory], AFError>) -> Void)
}

// MARK: - ProductCategoryService Class
final class ProductCategoryService {}

// MARK: - Extension - ProductCategoryService
extension ProductCategoryService: ProductCategoryServiceProtocol {
    func getCategories(completion: @escaping (Result<[ProductCategory], AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "neobook.online"
        urlComponent.path = "/ecobak/product-category-list/"

        guard let url = urlComponent.url else {
            completion(.failure(.invalidURL(url: urlComponent)))
            return
        }

        AF.request(url, method: .get, headers: ["accept": "application/json"])
            .validate()
            .responseDecodable(of: [ProductCategory].self) { response in
                completion(response.result)
            }
    }
}
