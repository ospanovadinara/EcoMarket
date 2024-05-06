//
//  ProductPresenter.swift
//  EcoMarket
//
//  Created by Dinara on 04.05.2024.
//

import Foundation

protocol ProductPresenterProtocol: AnyObject {
    var view: ProductViewControllerProtocol? { get set }
    func viewDidLoad()
}

final class ProductPresenter {
    weak var view: ProductViewControllerProtocol?
    private var productService = ProductService()
    private var selectedCategory: ProductCategory
    var products: [Product] = []

    init(selectedCategory: ProductCategory) {
        self.selectedCategory = selectedCategory
    }
}

extension ProductPresenter: ProductPresenterProtocol {
    func viewDidLoad() {
        productService.getProducts { result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async { [weak self] in
                    self?.products = products.filter { $0.category == self?.selectedCategory.id }
                    self?.view?.updateProducts()
                }
            case.failure(let error):
                print("Error fetching categories: \(error)")
            }
        }
    }
}
