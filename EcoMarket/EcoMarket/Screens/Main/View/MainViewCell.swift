//
//  MainViewCell.swift
//  EcoMarket
//
//  Created by Dinara on 02.05.2024.
//

import Kingfisher
import SnapKit
import UIKit

final class MainViewCell: UICollectionViewCell {
    // MARK: - UI
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 16
        return image
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = Fonts.semibold.s20()
        label.textColor = Colors.white.uiColor
        label.textAlignment = .left
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
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

    // MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradientLayers()
    }
}

// MARK: - Private Extension - MainViewCell
private extension MainViewCell {
    // MARK: - Setup Views
    func setupViews() {
        [imageView,
         label
        ].forEach { contentView.addSubview($0) }
    }

    // MARK: - Setup Constraints
    func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.width.equalTo(166)
            make.height.equalTo(180)
            make.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.width.equalTo(166)
            make.height.equalTo(180)
        }

        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }

    // MARK: - Setup Gradient
    func setupGradientLayers() {
        imageView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        let width = bounds.width
        let height = bounds.height
        let sHeight:CGFloat = 100.0
        let shadow = UIColor.black.withAlphaComponent(0.7).cgColor

        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: height - sHeight, width: width, height: sHeight)
        gradient.colors = [UIColor.clear.cgColor, shadow]
        imageView.layer.insertSublayer(gradient, at: 0)
    }
}

// MARK: - Extension - MainViewCell
extension MainViewCell {
    // MARK: - Public Properties
    public static let id = String(describing: MainViewCell.self)

    // MARK: - Public Methods
    public func configureCell(with model: ProductCategory) {
        label.text = model.name
        let imageUrl = model.image

        if let url = URL(string: imageUrl) {
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = nil
        }
    }
}
