//
//  AlbumDetailsFactoryContainer.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import SwiftUI

struct AlbumDetailsFactoryContainer {
    private static func repository() -> AlbumDetailsRepository {
        AlbumDetailsRepositoryImplementation()
    }

    private static func useCase() -> AlbumDetailsUseCase {
        AlbumDetailsImplementation(repository: Self.repository())
    }

    @MainActor
    private static func viewModel(_ coordinator: AlbumDetailsCoordinator) -> AlbumDetailsViewModel {
        AlbumDetailsViewModelImplementation(useCase: Self.useCase(), coordinator: coordinator)
    }

    @MainActor
    static private func viewController(_ coordinator: AlbumDetailsCoordinator) -> UIViewController {
        AlbumDetailsViewController(viewModel: Self.viewModel(coordinator))
    }
    
    @MainActor
    static func coordintor(_ navigationCotroller: UINavigationController) -> Coordinator {
        AlbumDetailsCoordinatorImplementation(navigationController: navigationCotroller, viewController: Self.viewController)
    }
}
