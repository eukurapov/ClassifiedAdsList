//
//  AppCoordinator.swift
//  ClassifiedAdsList
//
//  Created by evgenii.kurapov on 11.08.23.
//

import UIKit

final class AppCoordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let networkService = NetworkService()
        let viewModel = ClassifiedsListViewModel(
            getClassifiedsUseCase: GetClassifiedsUseCase(
                classifiedsRepository: ClassifiedsRepository(
                    classifiedsAPIService: ClassifiedsAPIService(network: networkService),
                    categoriesAPIService: CategoriesAPIService(network: networkService)
                )
            ),
            getImageUseCase: GetImageUseCase(
                imageRepository: ImageRepository(
                    imageCache: nil,
                    imageAPIService: ImageAPIService()
                )
            ),
            selectionHandler: { [weak self] classifiedViewModel in
                self?.navigateToDetailsView(viewModel: classifiedViewModel)
            }
        )
        let viewController = ClassifiedsListViewController(
            viewModel: viewModel
        )
        navigationController.pushViewController(viewController, animated: true)
    }

    private func navigateToDetailsView(viewModel: ClassifiedViewModel) {
        let viewController = DetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
