//
//  BottomSheetViewController.swift
//  EcoMarket
//
//  Created by Dinara on 12.05.2024.
//

import UIKit
import SnapKit
import PanModal

final class BottomSheetViewController: UIViewController {

    // MARK: - Mock Data
    private lazy var selectedProducts: [MockProduct] = [
        MockProduct(
            id: 1,
            title: "Яблоко золотая радуга",
            description: "Цена 56 с за шт",
            image: UIImage(named: "apples_image") ?? UIImage(),
            price: "56"
        ),
        MockProduct(
            id: 1,
            title: "Яблоко золотая радуга",
            description: "Цена 56 с за шт",
            image: UIImage(named: "apples_image") ?? UIImage(),
            price: "56"
        ),
        MockProduct(
            id: 1,
            title: "Яблоко золотая радуга",
            description: "Цена 56 с за шт",
            image: UIImage(named: "apples_image") ?? UIImage(),
            price: "56"
        ),
        MockProduct(
            id: 1,
            title: "Яблоко золотая радуга",
            description: "Цена 56 с за шт",
            image: UIImage(named: "apples_image") ?? UIImage(),
            price: "56"
        )
    ]

    // MARK: - UI
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: self.layout
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            BottomSheetViewCell.self,
            forCellWithReuseIdentifier: BottomSheetViewCell.id
        )
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    private lazy var sumLabel: UILabel = {
        let label = UILabel()
        label.text = "Сумма"
        label.font = Fonts.medium.s16()
        label.textColor = Colors.gray.uiColor
        label.textAlignment = .left
        return label
    }()

    private lazy var deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Доставка"
        label.font = Fonts.medium.s16()
        label.textColor = Colors.gray.uiColor
        label.textAlignment = .left
        return label
    }()

    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Итого"
        label.font = Fonts.medium.s16()
        label.textColor = Colors.gray.uiColor
        label.textAlignment = .left
        return label
    }()

    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private lazy var sumCounter: UILabel = {
        let label = UILabel()
        label.text = "396 тг"
        label.font = Fonts.medium.s16()
        label.textColor = Colors.black.uiColor
        label.textAlignment = .left
        return label
    }()

    private lazy var deliveryCounter: UILabel = {
        let label = UILabel()
        label.text = "150 тг"
        label.font = Fonts.medium.s16()
        label.textColor = Colors.black.uiColor
        label.textAlignment = .left
        return label
    }()

    private lazy var totalCounter: UILabel = {
        let label = UILabel()
        label.text = "546 тг"
        label.font = Fonts.medium.s16()
        label.textColor = Colors.black.uiColor
        label.textAlignment = .left
        return label
    }()

    private lazy var countersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private lazy var makeOrderButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.setTitle("Оформить заказ", for: .normal)
        button.setTitleColor(Colors.white.uiColor, for: .normal)
        button.titleLabel?.font = Fonts.semibold.s16()
        button.backgroundColor = Colors.green.uiColor
        button.addTarget(self,
                         action: #selector(makeOrderButtonDidTap),
                         for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

private extension BottomSheetViewController {

    func setupViews() {
        view.backgroundColor = .systemBackground

        [sumLabel,
         deliveryLabel,
         totalLabel
        ].forEach {
            labelsStackView.addArrangedSubview($0)
        }

        [sumCounter,
         deliveryCounter,
         totalCounter
        ].forEach {
            countersStackView.addArrangedSubview($0)
        }
        
        [collectionView,
         labelsStackView,
         countersStackView,
         makeOrderButton
        ].forEach {
            view.addSubview($0)
        }
    }

    // MARK: - Setup Constraints
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(labelsStackView.snp.top).offset(-20)
            make.height.equalTo(calculateCollectionViewHeight())
        }

        labelsStackView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(makeOrderButton.snp.top).offset(-86)
        }

        countersStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(labelsStackView.snp.centerY)
        }

        makeOrderButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(54)
        }
    }

    // MARK: - Actions
    @objc func makeOrderButtonDidTap() {
        //TODO
    }
}

extension BottomSheetViewController {
    private func calculateCollectionViewHeight() -> CGFloat {
        let cellHeight: CGFloat = 94
        let numberOfItems = selectedProducts.count
        let minimumInteritemSpacing: CGFloat = 12
        let totalCellHeight = cellHeight * CGFloat(numberOfItems)
        let totalInteritemSpacing = minimumInteritemSpacing * CGFloat(max(0, numberOfItems - 1))
        return totalCellHeight + totalInteritemSpacing
    }
}

// MARK: - UICollectionViewDataSource
extension BottomSheetViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BottomSheetViewCell.id,
            for: indexPath) as? BottomSheetViewCell else {
            fatalError("Could not cast to BottomSheetViewCell")
        }
        let model = selectedProducts[indexPath.item] 
        cell.configureCell(with: model)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension BottomSheetViewController: UICollectionViewDelegate {
    //TODO
}

extension BottomSheetViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = view.frame.width
        return CGSize(width: screenWidth, height: 94)
    }
}

extension BottomSheetViewController: PanModalPresentable {
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
