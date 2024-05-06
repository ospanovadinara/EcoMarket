//
//  ProductCell.swift
//  EcoMarket
//
//  Created by Dinara on 04.05.2024.
//
import Kingfisher
import SnapKit
import UIKit

final class ProductCell: UICollectionViewCell {
    private var productCount = 0

    // MARK: - UI
    private lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.lightGray.uiColor
        view.layer.cornerRadius = 16
        return view
    }()

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        image.contentMode = .scaleAspectFit
        return image
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = Fonts.medium.s14()
        label.textColor = Colors.black.uiColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.semibold.s20()
        label.textColor = Colors.green.uiColor
        label.textAlignment = .left
        return label
    }()

    lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "тг"
        label.font = Fonts.semibold.s14()
        label.textColor = Colors.green.uiColor
        return label
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ProductCell {
    func setupViews() {
        [imageView,
        title
        ].forEach { stackView.addArrangedSubview($0) }

        [stackView,
         priceLabel,
         currencyLabel,
         addButton,
         minusButton,
         plusButton,
         counterLabel
        ].forEach { view.addSubview($0)}

        contentView.addSubview(view)
    }

    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(228)
            make.width.equalTo(166)
        }

        view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
        }

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(96)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(4)
            make.bottom.equalTo(addButton.snp.top).offset(-16)
        }

        currencyLabel.snp.makeConstraints { make in
            make.leading.equalTo(priceLabel.snp.trailing).offset(2)
            make.bottom.equalTo(priceLabel.snp.bottom)
        }

        addButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview().offset(-4)
            make.height.equalTo(32)
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
        addButton.isHidden = true
        plusButton.isHidden = false
        minusButton.isHidden = false
        counterLabel.isHidden = false
        counterLabel.text = "\(productCount)"
    }
}

extension ProductCell {
    // MARK: - Public properties
    public static let cellID = String(describing: ProductCell.self)

    // MARK: - Public Methods
    public func configureCell(with model: Product) {
        title.text = model.title
        let priceString = model.price
        let imageUrl = model.image

        if let price = Double(priceString) {
            let priceInteger = Int(price)
            priceLabel.text = "\(priceInteger)"
        } else {
            priceLabel.text = "Not founded"
        }

        if let url = URL(string: imageUrl) {
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = nil
        }
    }
}
