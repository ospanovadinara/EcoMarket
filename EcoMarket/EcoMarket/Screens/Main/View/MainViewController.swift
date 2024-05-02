//
//  MainViewController.swift
//  EcoMarket
//
//  Created by Dinara on 30.04.2024.
//

import SnapKit
import UIKit

protocol MainViewControllerProtocol: AnyObject {
    var presenter: MainPresenter? { get set }
    func reloadCategories()
}

final class MainViewController: UIViewController {

    // MARK: - Private Properties
    var presenter: MainPresenter?

    // MARK: - UI
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: view.frame.width,
                                          height: view.frame.height)
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: 16,
            bottom: 0,
            right: 16
        )
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            MainViewCell.self,
            forCellWithReuseIdentifier: MainViewCell.id
        )
        collectionView.register(
            MainHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MainHeader.headerID
        )
        return collectionView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        presenter = MainPresenter()
        presenter?.view = self
        presenter?.viewDidLoad()
    }
}

// MARK: - Private Extension - MainViewController
private extension MainViewController {
    // MARK: - Setup Views
    func setupViews() {
        view.addSubview(collectionView)
    }

    // MARK: - Setup Constraints
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - MainViewControllerProtocol
extension MainViewController: MainViewControllerProtocol {
    func reloadCategories() {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        return presenter?.categories.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainViewCell.id,
            for: indexPath) as? MainViewCell else {
            fatalError("Could not cast to MainViewCell")
        }
        guard  let model = presenter?.categories[indexPath.item] else {
            return UICollectionViewCell()
        }
        cell.configureCell(with: model)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: MainHeader.headerID,
            for: indexPath
        ) as? MainHeader else {
            fatalError("Could not cast to MainHeader")
        }
        return header
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       //TODO
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44)
    }
}
