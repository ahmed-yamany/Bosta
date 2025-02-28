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
    private static func viewModel(_ coordinator: AlbumDetailsCoordinator, _ album: AlbumEntity) -> AlbumDetailsViewModel {
        AlbumDetailsViewModelImplementation(useCase: Self.useCase(), coordinator: coordinator, album: album)
    }

    @MainActor
    private static func viewController(_ coordinator: AlbumDetailsCoordinator, _ album: AlbumEntity) -> UIViewController {
        AlbumDetailsViewController(viewModel: Self.viewModel(coordinator, album))
    }

    @MainActor
    static func coordintor(_ navigationCotroller: UINavigationController, _ album: AlbumEntity) -> Coordinator {
        AlbumDetailsCoordinatorImplementation(
            navigationController: navigationCotroller,
            viewController: Self.viewController,
            album: album
        )
    }
}
