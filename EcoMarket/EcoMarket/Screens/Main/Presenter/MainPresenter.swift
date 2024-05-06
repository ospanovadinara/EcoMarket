//
//  MainPresenter.swift
//  EcoMarket
//
//  Created by Dinara on 02.05.2024.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    var view: MainViewControllerProtocol? { get set }
    func getCategories()
}

final class MainPresenter {
    weak var view: MainViewControllerProtocol?
    private var productCategoryService = ProductCategoryService()
    var categories: [ProductCategory] = []
}

extension MainPresenter: MainPresenterProtocol {
    func getCategories() {
        productCategoryService.getCategories { result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async { [weak self] in
                    self?.categories = categories
                    self?.view?.updateCategories()
                }
            case.failure(let error):
                print("Error fetching categories: \(error)")
            }
        }
    }
}

