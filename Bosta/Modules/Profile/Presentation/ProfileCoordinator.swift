//
//  ProfileCoordinator.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import UIKit

protocol ProfileCoordinator: Coordinator {
}

final class ProfileCoordinatorImpl: ProfileCoordinator {
    let navigationController: UINavigationController
    let viewController: UIViewController

    init(navigationController: UINavigationController, viewController: UIViewController) {
        self.navigationController = navigationController
        self.viewController = viewController
    }

    func start() {
        navigationController.setViewControllers([viewController], animated: true)
    }
}
