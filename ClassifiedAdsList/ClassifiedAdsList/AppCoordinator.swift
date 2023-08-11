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
        let viewController = ViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
