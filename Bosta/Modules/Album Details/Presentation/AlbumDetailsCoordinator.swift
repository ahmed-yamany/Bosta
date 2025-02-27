//
//  AlbumDetailsCoordinator.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//


import UIKit

protocol AlbumDetailsCoordinator: Coordinator {
}

final class AlbumDetailsCoordinatorImplementation: AlbumDetailsCoordinator {
    typealias VCType = (AlbumDetailsCoordinator) -> UIViewController
    
    let navigationController: UINavigationController
    let viewController: VCType

    init(
        navigationController: UINavigationController,
        viewController: @escaping VCType
    ) {
        self.navigationController = navigationController
        self.viewController = viewController
    }

    func start() {
        navigationController.pushViewController(viewController(self), animated: true)
    }
}
