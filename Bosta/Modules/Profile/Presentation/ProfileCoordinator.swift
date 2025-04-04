//
//  ProfileCoordinator.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import UIKit

protocol ProfileCoordinator {
    func navigateToAlbum(_ album: AlbumEntity)
}

final class ProfileCoordinatorImpl: ProfileCoordinator, Coordinator {
    typealias VCType = (ProfileCoordinatorImpl) -> UIViewController
    
    let navigationController: UINavigationController
    let viewController: VCType

    init(navigationController: UINavigationController, viewController: @escaping VCType) {
        self.navigationController = navigationController
        self.viewController = viewController
    }

    func start() {
        navigationController.setViewControllers([viewController(self)], animated: true)
    }
    
    func navigateToAlbum(_ album: AlbumEntity) {
        AlbumDetailsFactoryContainer.coordintor(navigationController, album).start()
    }
}
