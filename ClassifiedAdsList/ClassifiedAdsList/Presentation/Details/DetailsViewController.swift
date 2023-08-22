//
//  DetailsViewController.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 22.08.23.
//

import Combine
import UIKit

final class DetailsViewController: UIViewController {

    private let viewModel: ClassifiedViewModel

    private var containerView: UIScrollView?
    private var imageView: UIImageView?
    private var descriptionLabel: UILabel?

    private var cancellable: Cancellable?

    init(viewModel: ClassifiedViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = viewModel.title
        if let thumbImageData = viewModel.thumbImageData {
            imageView?.image = UIImage(data: thumbImageData)
        }
        cancellable = viewModel.$smallImageData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let result else { return }
                self?.imageView?.image = UIImage(data: result)
            }
        viewModel.fetchSmallImage()
        descriptionLabel?.text = viewModel.description
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
    }

    private func setupSubviews() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        self.containerView = scrollView

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        self.imageView = imageView

        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        self.descriptionLabel = descriptionLabel

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.4),

            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16)
        ])
    }
}
