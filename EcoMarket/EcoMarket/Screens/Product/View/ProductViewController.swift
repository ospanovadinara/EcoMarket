//
//  ProductViewController.swift
//  EcoMarket
//
//  Created by Dinara on 02.05.2024.
//

import SnapKit
import UIKit

protocol ProductViewControllerProtocol: AnyObject {
    var productPresenter: ProductPresenter? { get set }
    func updateProducts()
}

final class ProductViewController: UIViewController {
    // MARK: - Private Properties
    var mainPresenter: MainPresenter?
    var productPresenter: ProductPresenter?
    private var selectedCategory: ProductCategory?

    // MARK: - UI
    private lazy var searchImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "search_image"))
        imageView.frame = CGRect(x: 0, y: 0, width: 17, height: 17)
        return imageView
    }()

    private lazy var searchBar: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Colors.lightGray.uiColor

        let container = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 17))
        container.addSubview(searchImageView)
        searchImageView.frame.origin.x = 15
        textField.leftView = container
        textField.leftViewMode = .always

        textField.layer.cornerRadius = 16
        textField.placeholder = "Быстрый поиск"
        textField.textAlignment = .left
        textField.textColor = Colors.gray.uiColor
        textField.font = Fonts.medium.s16()
        textField.delegate = self
        textField.addTarget(self, action: #selector(searchButtonDidTap), for: .editingChanged)
        return textField
    }()

    private lazy var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            CategoryCell.self,
            forCellWithReuseIdentifier: CategoryCell.cellID
        )
        return collectionView
    }()

    private lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 11
        layout.minimumLineSpacing = 11
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 16,
                                           bottom: 0,
                                           right: 16)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            ProductCell.self,
            forCellWithReuseIdentifier: ProductCell.cellID
        )
        return collectionView
    }()

    private lazy var basketButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.backgroundColor = Colors.green.uiColor
        button.addTarget(self, action: #selector(basketButtonDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var basketLabel: UILabel = {
        let label = UILabel()
        label.text = "Корзина"
        label.font = Fonts.medium.s16()
        label.textColor = .white
        return label
    }()

    private lazy var basketImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "basket_image")
        return image
    }()

    init(selectedCategory: ProductCategory?) {
        self.selectedCategory = selectedCategory
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupViews()
        setupConstraints()
        setupMainPresenter()
        setupProductPresenter()
    }
}

private extension ProductViewController {
    // MARK: - Setup Navigation Controller
    func setupNavigationController() {
        self.navigationItem.title = "Продукты"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "left_arrow_icon"),
            style: .plain,
            target: self,
            action: #selector(backButtonDidTap))
    }

    // MARK: - Setup Views
    func setupViews() {
        [searchBar,
         categoriesCollectionView,
         productsCollectionView,
         basketButton,
         basketLabel
        ].forEach {
            view.addSubview($0)
        }

        [basketImage,
         basketLabel
        ].forEach {
            basketButton.addSubview($0)
        }
    }

    // MARK: - Setup Constraints
    func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }

        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(27)
        }

        productsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollectionView.snp.bottom).offset(24)
            make.leading.trailing.bottom.equalToSuperview()
        }

        basketImage.snp.makeConstraints { make in
            make.top.equalTo(basketButton.snp.top).offset(12)
            make.leading.equalTo(basketButton.snp.leading).offset(16)
            make.bottom.equalTo(basketButton.snp.bottom).offset(-12)
        }

        basketLabel.snp.makeConstraints { make in
            make.leading.equalTo(basketImage.snp.trailing).offset(6)
            make.centerY.equalTo(basketImage.snp.centerY)
        }

        basketButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalTo(168)
            make.height.equalTo(48)
        }
    }

    // MARK: - Actions
    @objc func basketButtonDidTap() {
        //TODO
    }

    @objc func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }

    @objc func searchButtonDidTap() {
        //TODO
    }
}

extension ProductViewController {
    func setupMainPresenter() {
        mainPresenter = MainPresenter()
        mainPresenter?.view = self
        mainPresenter?.getCategories()
    }

    func setupProductPresenter() {
        if let category = selectedCategory {
            productPresenter = ProductPresenter(selectedCategory: category)
        }
        productPresenter?.view = self
        productPresenter?.getProducts()
    }
}


extension ProductViewController: MainViewControllerProtocol {
    func updateCategories() {
        categoriesCollectionView.reloadData()
    }
}


extension ProductViewController: ProductViewControllerProtocol {
    func updateProducts() {
        productsCollectionView.reloadData()
    }
}

extension ProductViewController: UITextFieldDelegate {
    //TODO
}

extension ProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollectionView {
            return mainPresenter?.categories.count ?? 0
        } else if collectionView == productsCollectionView {
            return productPresenter?.products.count ?? 0
        }

        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.cellID,
                for: indexPath) as? CategoryCell else {
                fatalError("Could not cast to CategoryCell")
            }
            if let category = mainPresenter?.categories[indexPath.item] {
                cell.configureCell(title: category.name)
                let isSelected = category.id == selectedCategory?.id
                cell.updateBackgroundColor(isSelected: isSelected)
            }

            return cell
        } else if collectionView == productsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductCell.cellID,
                for: indexPath) as? ProductCell else {
                fatalError("Could not cast to ProductCell")
            }
            if let model = productPresenter?.products[indexPath.item] {
                cell.configureCell(with: model)
            }
            return cell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoriesCollectionView {
            if let category = mainPresenter?.categories[indexPath.item].name {
                let labelWidth = category.width(withConstrainedHeight: 27, font: Fonts.medium.s16())
                let cellWidth = labelWidth + 12
                return CGSize(width: cellWidth, height: 27)
            }
        } else if collectionView == productsCollectionView {
            let cellWidth = (collectionView.bounds.width - 16 * 3) / 2
            let cellHeight: CGFloat = 228
            return CGSize(width: cellWidth, height: cellHeight)
        }
        return CGSize(width: 50, height: 50)
    }
}

// MARK: - UICollectionViewDelegate
extension ProductViewController:  UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO
    }
}
