//
//  BottomSheetViewCell.swift
//  EcoMarket
//
//  Created by Dinara on 12.05.2024.
//

import UIKit
import SnapKit

final class BottomSheetViewCell: UICollectionViewCell {
    // MARK: - UI
    private lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.lightGray.uiColor
        view.layer.cornerRadius = 12
        return view
    }()

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 16
        return image
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = Fonts.medium.s14()
        label.textColor = Colors.black.uiColor
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel : UILabel = {
       let label = UILabel()
        label.font = Fonts.medium.s12()
        label.textColor = Colors.gray.uiColor
        label.textAlignment = .left
        label.numberOfLines = 0
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

    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "тг"
        label.font = Fonts.semibold.s14()
        label.textColor = Colors.green.uiColor
        return label
    }()

    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        return stackView
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
        label.text = "1"
        label.font = Fonts.medium.s18()
        label.textColor = Colors.black.uiColor
        label.textAlignment = .center
        return label
    }()

    private lazy var quantityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()

  

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Extension - BottomSheetViewCell
private extension BottomSheetViewCell {
    // MARK: - Setup Views
    func setupViews() {
        [title,
         descriptionLabel
        ].forEach {
            stackView.addArrangedSubview($0)
        }

        [priceLabel,
         currencyLabel
        ].forEach {
            priceStackView.addArrangedSubview($0)
        }

        [plusButton,
         counterLabel,
         minusButton
        ].forEach {
            quantityStackView.addArrangedSubview($0)
        }

        [imageView,
         stackView,
         priceStackView,
         quantityStackView
        ].forEach { background.addSubview($0) }

        contentView.addSubview(background)
    }

    // MARK: - Setup Constraints
    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        background.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(
                UIEdgeInsets(
                    top: 0,
                    left: 16,
                    bottom: 0,
                    right: 16
                )
            )
        }

        imageView.snp.makeConstraints { make in
            make.top.equalTo(background.snp.top).offset(4)
            make.leading.equalTo(background.snp.leading).offset(4)
            make.height.equalTo(86)
            make.width.equalTo(98)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.top).offset(4)
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.height.equalTo(35)
        }

        priceStackView.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.bottom.equalTo(imageView.snp.bottom).offset(-4)
            make.height.equalTo(15)
        }

        quantityStackView.snp.makeConstraints { make in
            make.trailing.equalTo(background.snp.trailing).offset(-4)
            make.bottom.equalTo(background.snp.bottom).offset(-4)
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
}


// MARK: - Extension - BottomSheetViewCell
extension BottomSheetViewCell {
    // MARK: - Public Properties
    public static let id = String(describing: BottomSheetViewCell.self)

    // MARK: - Public Methods
    public func configureCell(with model: MockProduct) {
        title.text = model.title
        descriptionLabel.text = model.description
        priceLabel.text = model.price
        imageView.image = model.image
    }
}
