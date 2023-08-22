//
//  ClassifiedsListViewController.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 21.08.23.
//

import Combine
import UIKit

final class ClassifiedsListViewController: UICollectionViewController {

    private let viewModel: ClassifiedsListViewModel
    private var cancellable: AnyCancellable?

    private let listCellIdentifier = "ListCell"

    init(viewModel: ClassifiedsListViewModel) {
        self.viewModel = viewModel

        let layout = UICollectionViewCompositionalLayout { _, environment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            return NSCollectionLayoutSection(group: group)
        }

        super.init(collectionViewLayout: layout)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ClassifiedCell.self, forCellWithReuseIdentifier: ClassifiedCell.identifier)

        cancellable = viewModel.$classifieds
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
        viewModel.fetch()

        title = "Classifieds"
    }
}

// MARK: - DataSource

extension ClassifiedsListViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.classifieds.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let classifiedViewModel = viewModel.classifiedViewModel(for: indexPath) else {
            return UICollectionViewCell()
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifiedCell.identifier, for: indexPath) as? ClassifiedCell {
            cell.bind(viewModel: classifiedViewModel)
            return cell
        } else {
            return  UICollectionViewCell()
        }
    }
}

// MARK: - CollectionView Delegate

extension ClassifiedsListViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectItem(indexPath: indexPath)
    }
}
