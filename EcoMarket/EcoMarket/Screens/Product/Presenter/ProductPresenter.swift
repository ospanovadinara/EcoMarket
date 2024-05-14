//
//  ProductPresenter.swift
//  EcoMarket
//
//  Created by Dinara on 04.05.2024.
//

import Foundation

protocol ProductPresenterProtocol: AnyObject {
    var view: ProductViewControllerProtocol? { get set }
    func getProducts()
    func updateSelectedCategory(_ category: ProductCategory)
}

final class ProductPresenter {
    weak var view: ProductViewControllerProtocol?
    private var productService = ProductService()
    private var selectedCategory: ProductCategory

    var products: [Product] = []
    var selectedProducts: [Product] = []
    
    init(selectedCategory: ProductCategory) {
        self.selectedCategory = selectedCategory
    }
}

extension ProductPresenter: ProductPresenterProtocol {
    func getProducts() {
        productService.getProducts { result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async { [weak self] in
                    self?.products = products.results.filter { $0.category == self?.selectedCategory.id }
                    self?.view?.updateProducts()
                }
            case.failure(let error):
                print("Error fetching products: \(error)")
            }
        }
    }

    func updateSelectedCategory(_ category: ProductCategory) {
        self.selectedCategory = category
        getProducts()
    }
}

extension ProductPresenter {
    func calculateTotalPrice() -> Int {
        var totalPrice: Int = 0
        for product in selectedProducts {
            if let price = Double(product.price) {
                totalPrice += product.quantity * Int(price)
            }
        }

        return totalPrice
    }

    func addToBasket(product: Product) {
        if let index = selectedProducts.firstIndex(where: { $0.id == product.id }) {
            selectedProducts[index].quantity += 1
        } else {
            var newProduct = product
            newProduct.quantity = 1
            selectedProducts.append(newProduct)
        }
        view?.updateBasketCounter()
    }
}
