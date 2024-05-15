//
//  ProductDescriptionViewController.swift
//  EcoMarket
//
//  Created by Dinara on 14.05.2024.
//

import UIKit
import SnapKit
import PanModal

final class DescriptionViewController: UIViewController {
    private var productCount = 0
    private lazy var selectedProducts: [MockProduct] = [
        MockProduct(
            id: 1,
            title: "Яблоко золотая радуга",
            description: "Cочный плод яблони, который употребляется в пищу в свежем и запеченном виде, служит сырьём в кулинарии и для приготовления напитков.",
            image: UIImage(named: "apples_image") ?? UIImage(),
            price: "56"
        )
    ]

    // MARK: - UI
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        image.contentMode = .scaleAspectFill
        return image
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = Fonts.semibold.s24()
        label.textColor = Colors.black.uiColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.regular.s16()
        label.textColor = Colors.lightGray.uiColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.semibold.s24()
        label.textColor = Colors.green.uiColor
        label.textAlignment = .left
        return label
    }()

    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "тг шт"
        label.font = Fonts.semibold.s24()
        label.textColor = Colors.green.uiColor
        return label
    }()

    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Fonts.medium.s16()
        button.backgroundColor = Colors.green.uiColor
        button.addTarget(self,
                         action: #selector(addButtonDidTap),
                         for: .touchUpInside)
        return button
    }()

    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.semibold.s24()
        label.textColor = Colors.black.uiColor
        label.textAlignment = .left
        return label
    }()

    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 16
        button.addTarget(self,
                         action: #selector(minusButtonDidTap),
                         for: .touchUpInside)
        button.setTitle("-", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Colors.green.uiColor
        button.isHidden = true
        return button
    }()

    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.addTarget(self,
                         action: #selector(plusButtonDidTap),
                         for: .touchUpInside)
        button.setTitle("+", for: .normal)
        button.tintColor = .white
        button.backgroundColor = Colors.green.uiColor
        button.isHidden = true
        return button
    }()

    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.text = "\(productCount)"
        label.font = Fonts.medium.s18()
        label.textColor = Colors.black.uiColor
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

private extension DescriptionViewController {
    func setupViews() {
        [priceLabel,
         currencyLabel
        ].forEach {
            priceStackView.addArrangedSubview($0)
        }

        [imageView,
         label,
         priceStackView,
         descriptionLabel
        ].forEach {
            stackView.addArrangedSubview($0)
        }

        [stackView,
         addButton,
         minusButton,
         plusButton,
         counterLabel
        ].forEach { 
            view.addSubview($0)
        }
    }

    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(96)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        addButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(54)
        }

        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(4)
            make.bottom.equalTo(addButton.snp.top).offset(-16)
        }

        minusButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.height.equalTo(32)
        }

        plusButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-4)
            make.height.equalTo(32)
        }

        counterLabel.snp.makeConstraints { make in
            make.centerY.equalTo(plusButton.snp.centerY)
            make.centerX.equalToSuperview()
        }
    }


    // MARK: - Actions
    @objc func minusButtonDidTap() {
        //TODO
    }

    @objc func plusButtonDidTap() {
        //TODO
    }

    @objc func addButtonDidTap() {
        productCount += 1

//        didTapAddButton?()

        addButton.isHidden = true
        plusButton.isHidden = false
        minusButton.isHidden = false
        counterLabel.isHidden = false
        counterLabel.text = "\(productCount)"

//        if let presenter = productPresenter,
//           var product = presenter.products.first(where: { $0.title == title.text }) {
//            presenter.addToBasket(product: product)
//            presenter.products = presenter.selectedProducts
//        }
    }
}

extension DescriptionViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(519)
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(5)
    }
}
