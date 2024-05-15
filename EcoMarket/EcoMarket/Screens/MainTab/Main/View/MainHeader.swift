//
//  MainHeader.swift
//  EcoMarket
//
//  Created by Dinara on 02.05.2024.
//
import SnapKit
import UIKit

final class MainHeader: UICollectionReusableView {
    // MARK: - Cell Identifier
    public static let headerID = String(describing: MainHeader.self)

    // MARK: - UI
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Эко Маркет"
        label.textColor = Colors.black.uiColor
        label.font = Fonts.semibold.s24()
        return label
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("Error in Cell")
    }
}

// MARK: - Private Extension - MainHeader
private extension MainHeader {
    // MARK: - Setup Views
    func setupViews() {
        self.addSubview(label)
    }

    // MARK: - Setup Constraints
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
    }
}
