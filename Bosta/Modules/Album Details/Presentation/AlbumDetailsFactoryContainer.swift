//
//  AlbumDetailsFactoryContainer.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import Moya
import SwiftUI

struct AlbumDetailsFactoryContainer {
    private static func repository() -> AlbumDetailsRepository {
        let albumDetailsProvider = MoyaProvider<AlbumDetailsTarget>()
        return AlbumDetailsRepositoryImplementation(albumDetailsProvider: albumDetailsProvider)
    }

    private static func useCase() -> AlbumDetailsUseCase {
        AlbumDetailsUseCaseImplementation(repository: Self.repository())
    }

    @MainActor
    private static func viewModel(_ coordinator: AlbumDetailsCoordinatorImp, _ album: AlbumEntity) -> AlbumDetailsViewModel {
        AlbumDetailsViewModelImplementation(useCase: Self.useCase(), coordinator: WeakReferance(object: coordinator), album: album)
    }

    @MainActor
    private static func viewController(_ coordinator: AlbumDetailsCoordinatorImp, _ album: AlbumEntity) -> UIViewController {
        AlbumDetailsViewController(viewModel: Self.viewModel(coordinator, album))
    }

    @MainActor
    static func coordintor(_ navigationCotroller: UINavigationController, _ album: AlbumEntity) -> Coordinator {
        AlbumDetailsCoordinatorImp(
            navigationController: navigationCotroller,
            viewController: Self.viewController,
            album: album
        )
    }
}

extension WeakReferance: AlbumDetailsCoordinator where T: AlbumDetailsCoordinator {
}
