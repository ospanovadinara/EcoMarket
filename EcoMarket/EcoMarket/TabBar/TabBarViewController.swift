//
//  ViewController.swift
//  EcoMarket
//
//  Created by Dinara on 30.04.2024.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
}

private extension TabBarViewController {
    func setupTabBar() {
        view.backgroundColor = .systemBackground

        let mainVC = UINavigationController(rootViewController: MainViewController())
        let basketVC = UINavigationController(rootViewController: BasketViewController())
        let historyVC = UINavigationController(rootViewController: HistoryViewController())
        let infoVC = UINavigationController(rootViewController: InfoViewController())

        mainVC.tabBarItem = createTabItem(
            image: UIImage(named: "main"),
            selectedImage: UIImage(named: "main_selected"),
            title: "Главная"
        )

        basketVC.tabBarItem = createTabItem(
            image: UIImage(named: "basket"),
            selectedImage: UIImage(named: "basket_selected"),
            title: "Корзина"
        )

        historyVC.tabBarItem = createTabItem(
            image: UIImage(named: "history"),
            selectedImage: UIImage(named: "history_selected"),
            title: "История"
        )

        infoVC.tabBarItem = createTabItem(
            image: UIImage(named: "info"),
            selectedImage: UIImage(named: "info_selected"),
            title: "Инфо"
        )

        setViewControllers([mainVC, basketVC, historyVC, infoVC], animated: true)
        selectedIndex = 0

        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.systemGray5.cgColor
        tabBar.tintColor = Colors.green.uiColor
    }

    func createTabItem(
        image: UIImage?,
        selectedImage: UIImage?,
        title: String
    ) -> UITabBarItem {

        let item = UITabBarItem(
            title: title,
            image: image,
            selectedImage: selectedImage
        )

        return item
    }
}

enum TabItem: Int {
    case main
    case basket
    case history
    case info

    var image: UIImage? {
        switch self {
        case .main: return UIImage(named: "main")
        case .basket: return UIImage(named: "basket")
        case .history: return UIImage(named: "history")
        case .info: return UIImage(named: "info")
        }
    }

    var selectedImage: UIImage? {
        switch self {
        case .main: return UIImage(named: "main_selected")
        case .basket: return UIImage(named: "basket_selected")
        case .history: return UIImage(named: "history_selected")
        case .info: return UIImage(named: "info_selected")
        }
    }
}

