//
//  ClassifiedCell.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 22.08.23.
//

import Combine
import UIKit

final class ClassifiedCell: UICollectionViewCell {

    static let identifier = "ClassifiedCellIdentifier"

    private var viewModel: ClassifiedViewModel?

    private var imageView: UIImageView?
    private var titleLabel: UILabel?
    private var creationDateLabel: UILabel?
    private var categoryNameLabel: UILabel?
    private var urgentView: UIView?

    private var cancellable: Cancellable?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(viewModel: ClassifiedViewModel) {
        self.viewModel = viewModel
        imageView?.image = nil
        cancellable?.cancel()
        cancellable = viewModel.$thumbImageData.receive(on: DispatchQueue.main).sink {
            [weak self] imageData in
            guard let imageData else { return }
            self?.imageView?.image = UIImage(data: imageData)
        }
        viewModel.fetchThumbImage()
        titleLabel?.text = viewModel.title
        creationDateLabel?.text = viewModel.creationDateString
        categoryNameLabel?.text = viewModel.categoryName
        urgentView?.isHidden = !viewModel.isUrgent
    }

    private func setupSubviews() {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        contentView.addSubview(imageView)

        let titleLabel = UILabel()
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel = titleLabel
        contentView.addSubview(titleLabel)

        let creationDateLabel = UILabel()
        creationDateLabel.font = .preferredFont(forTextStyle: .caption1)
        creationDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.creationDateLabel = creationDateLabel
        contentView.addSubview(creationDateLabel)

        let categoryNameLabel = UILabel()
        categoryNameLabel.font = .preferredFont(forTextStyle: .caption1)
        categoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.categoryNameLabel = categoryNameLabel
        contentView.addSubview(categoryNameLabel)

        let urgentView = UIView()
        urgentView.layer.cornerRadius = 8
        urgentView.backgroundColor = .purple
        urgentView.translatesAutoresizingMaskIntoConstraints = false
        self.urgentView = urgentView
        urgentView.isHidden = true
        contentView.addSubview(urgentView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 16),

            urgentView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -8),
            urgentView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8),
            urgentView.widthAnchor.constraint(equalTo: urgentView.heightAnchor),
            urgentView.heightAnchor.constraint(equalToConstant: 16),

            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),

            creationDateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            creationDateLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: creationDateLabel.bottomAnchor, constant: 16),

            categoryNameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: creationDateLabel.trailingAnchor),
            categoryNameLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: categoryNameLabel.trailingAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: categoryNameLabel.bottomAnchor, constant: 16),
        ])
    }
}
