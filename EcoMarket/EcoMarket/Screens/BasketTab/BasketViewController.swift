//
//  BasketViewController.swift
//  EcoMarket
//
//  Created by Dinara on 30.04.2024.
//

import UIKit
import SnapKit

// MARK: - Class BasketViewController
final class BasketViewController: UIViewController {
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
        )
    ]

    // MARK: - UI
    private lazy var clearButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Очистить",
            style: .plain,
            target: self,
            action: #selector(clearButtonDidTap)
        )
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Colors.red.uiColor,
            .font: Fonts.medium.s18()
        ]
        button.setTitleTextAttributes(attributes, for: .normal)
        return button
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .grouped
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(
            BasketCell.self,
            forCellReuseIdentifier: BasketCell.id
        )
        tableView.backgroundColor = .systemBackground
        return tableView
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
        setupNavigationaBar()
        setupViews()
        setupConstraints()
    }
}

private extension BasketViewController {
    // MARK: - Setup Navigation

    func setupNavigationaBar() {
        navigationItem.title = "Корзина"
        navigationItem.leftBarButtonItem = clearButton
    }

    // MARK: - Setup Views
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

        [tableView,
         labelsStackView,
         countersStackView,
         makeOrderButton
        ].forEach {
            view.addSubview($0)
        }
    }

    // MARK: - Setup Constraints
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        labelsStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(makeOrderButton.snp.bottom).offset(-247)
            make.height.equalTo(75)
        }

        countersStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(labelsStackView.snp.centerY)
        }

        makeOrderButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(54)
        }
    }

    // MARK: - Actions
    @objc func makeOrderButtonDidTap() {
        //TODO
    }
    // MARK: - Actions
    @objc func clearButtonDidTap() {
        //TODO
    }
}

// MARK: - UITableViewDataSource
extension BasketViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BasketCell.id,
            for: indexPath
        ) as? BasketCell else  {
            fatalError("Could not cast to BasketCell")
        }
        let model = selectedProducts[indexPath.item]
        cell.configureCell(with: model)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
}
