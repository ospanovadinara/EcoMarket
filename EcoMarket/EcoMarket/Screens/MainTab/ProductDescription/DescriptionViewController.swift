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

    // MARK: - UI
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        image.image = UIImage(named: "apples_image")
        image.contentMode = .scaleAspectFill
        return image
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = Fonts.semibold.s24()
        label.textColor = Colors.black.uiColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Яблоко золотая радуга"
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.regular.s16()
        label.text = "Cочный плод яблони, который употребляется в пищу в свежем и запеченном виде, служит сырьём в кулинарии и для приготовления напитков."
        label.textColor = Colors.gray.uiColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.semibold.s24()
        label.textColor = Colors.green.uiColor
        label.text = "56"
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
        label.text = "112 тг"
        label.textAlignment = .left
        label.isHidden = true
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
        return button
    }()

    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.text = "\(productCount)"
        label.font = Fonts.medium.s18()
        label.textColor = Colors.black.uiColor
        label.textAlignment = .center
        return label
    }()

    private lazy var quantityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 41
        stackView.isHidden = true
        return stackView
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
        view.backgroundColor = .systemBackground
        
        [priceLabel,
         currencyLabel
        ].forEach {
            priceStackView.addArrangedSubview($0)
        }

        [imageView,
         label
        ].forEach {
            stackView.addArrangedSubview($0)
        }

        [minusButton,
         counterLabel,
         plusButton
        ].forEach {
            quantityStackView.addArrangedSubview($0)
        }

        [stackView,
         priceStackView,
         descriptionLabel,
         addButton,
         totalLabel,
         quantityStackView
        ].forEach {
            view.addSubview($0)
        }
    }

    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.height.equalTo(208)
            make.width.equalTo(343)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        priceStackView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(priceStackView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        addButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(54)
        }

        totalLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(quantityStackView.snp.centerY)
        }

        quantityStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(37)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(32)
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

        addButton.isHidden = true
        totalLabel.isHidden = false
        quantityStackView.isHidden = false
        counterLabel.text = "\(productCount)"
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
