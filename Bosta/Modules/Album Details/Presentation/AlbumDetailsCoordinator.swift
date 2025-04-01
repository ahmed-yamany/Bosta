//
//  AlbumDetailsCoordinator.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//


import UIKit

protocol AlbumDetailsCoordinator {
}

final class AlbumDetailsCoordinatorImp: AlbumDetailsCoordinator, Coordinator {
    typealias VCType = (AlbumDetailsCoordinatorImp, AlbumEntity) -> UIViewController
    
    let navigationController: UINavigationController
    let viewController: VCType
    let album: AlbumEntity
    
    init(
        navigationController: UINavigationController,
        viewController: @escaping VCType,
        album: AlbumEntity
    ) {
        self.navigationController = navigationController
        self.viewController = viewController
        self.album = album
    }

    func start() {
        navigationController.pushViewController(viewController(self, album), animated: true)
    }
}
