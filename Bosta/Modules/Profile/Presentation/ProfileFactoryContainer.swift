//
//  ProfileFactoryContainer.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import Moya
import UIKit

struct ProfileFactoryContainer {
    private static func repository() -> ProfileRepository {
        let usersProvider: MoyaProvider<UsersTarget> = .init()
        let albumsProvider: MoyaProvider<AlbumsTarget> = .init()
        return ProfileRepositoryImplementation(usersProvider: usersProvider, albumsProvider: albumsProvider)
    }

    private static func useCase() -> ProfileUseCase {
        ProfileUseCaseImplementation(repository: Self.repository())
    }

    @MainActor
    private static func viewModel(_ coordinator: ProfileCoordinatorImpl) -> ProfileViewModel {
        ProfileViewModelImplementation(useCase: Self.useCase(), coordinator: WeakReferance(object: coordinator))
    }

    @MainActor
    private static func viewController(_ coordinator: ProfileCoordinatorImpl) -> UIViewController {
        ProfileViewController(viewModel: Self.viewModel(coordinator))
    }

    @MainActor
    static func coordintor(_ navigationCotroller: UINavigationController) -> Coordinator {
        ProfileCoordinatorImpl(navigationController: navigationCotroller, viewController: Self.viewController)
    }
}

extension WeakReferance: ProfileCoordinator where T: ProfileCoordinator {
    func navigateToAlbum(_ album: AlbumEntity) {
        object?.navigateToAlbum(album)
    }
}
