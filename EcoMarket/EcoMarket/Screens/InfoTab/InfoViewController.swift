//
//  InfoViewController.swift
//  EcoMarket
//
//  Created by Dinara on 30.04.2024.
//

import UIKit
import SnapKit

// MARK: - Class InfoViewController
final class InfoViewController: UIViewController {
    // MARK: - UI
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.image = UIImage(named: "info_image")
        image.contentMode = .scaleAspectFill
        return image
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = Fonts.semibold.s24()
        label.textColor = Colors.black.uiColor
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Эко Маркет"
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.regular.s16()
        label.text = "Фрукты, овощи, зелень, сухофрукты а так же сделанные из натуральных ЭКО продуктов (варенье, салаты, соления, компоты и т.д.) можете заказать удобно, качественно и по доступной цене. \nГотовы сотрудничать взаимовыгодно с магазинами. \nНаши цены как на рынке. \nМы заинтересованы в экономии ваших денег и времени. \nСтоимость доставки 150 сом и ещё добавлен для окраину города. \nПри отказе подтвержденного заказа более \n2-х раз Клиент заносится в чёрный список!"
        label.textColor = Colors.gray.uiColor
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

    private lazy var callButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.setImage(UIImage(systemName: "phone"), for: .normal)
        button.tintColor = .black
        button.setTitle("Позвонить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Fonts.semibold.s16()
        button.backgroundColor = Colors.lightGray.uiColor
        button.addTarget(self,
                         action: #selector(callButtonDidTap),
                         for: .touchUpInside)
        return button
    }()

    private lazy var whatsappButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.setImage(UIImage(named: "whatsapp"), for: .normal)
        button.tintColor = .black
        button.setTitle("WhatsApp", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Fonts.semibold.s16()
        button.backgroundColor = Colors.lightGray.uiColor
        button.addTarget(self,
                         action: #selector(whatsappButtonDidTap),
                         for: .touchUpInside)
        return button
    }()

    private lazy var instagramButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.setImage(UIImage(named: "instagram"), for: .normal)
        button.tintColor = .black
        button.setTitle("Instagram", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Fonts.semibold.s16()
        button.backgroundColor = Colors.lightGray.uiColor
        button.addTarget(self,
                         action: #selector(instagramButtonDidTap),
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

    override func viewDidLayoutSubviews() {
        configureScrollView()
    }
}

private extension InfoViewController {
    // MARK: - Setup Navigation
    func setupNavigationaBar() {
        navigationItem.title = "Инфо"
        navigationController?.navigationBar.titleTextAttributes = [ .foregroundColor: Colors.black.uiColor ]
        navigationController?.navigationBar.backgroundColor = .clear
    }

    // MARK: - Setup Views
    func setupViews() {
        view.backgroundColor = .systemBackground

        [label,
         descriptionLabel
        ].forEach {
            stackView.addArrangedSubview($0)
        }

        [imageView,
         stackView,
         callButton,
         whatsappButton,
         instagramButton
        ].forEach {
            contentView.addSubview($0)
        }

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }

    // MARK: - Setup Constraints
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.leading.equalTo(scrollView)
            make.trailing.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(286)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        callButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(33)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(54)
        }

        whatsappButton.snp.makeConstraints { make in
            make.top.equalTo(callButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(54)
        }

        instagramButton.snp.makeConstraints { make in
            make.top.equalTo(whatsappButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(54)
        }
    }

    func configureScrollView() {
        scrollView.contentSize = CGSize(
            width: view.frame.size.width,
            height: view.bounds.height)
    }

    // MARK: - Actions
    @objc func callButtonDidTap() {
        //TODO
    }

    @objc func whatsappButtonDidTap() {
        //TODO
    }

    @objc func instagramButtonDidTap() {
        //TODO
    }
}
