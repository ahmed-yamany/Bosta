//
//  ProfileFactoryContainer.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import UIKit
import Moya

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
    private static func viewModel(_ coordinator: ProfileCoordinator) -> ProfileViewModel {
        ProfileViewModelImplementation(useCase: Self.useCase(), coordinator: coordinator)
    }

    @MainActor
    static private func viewController(_ coordinator: ProfileCoordinator) -> UIViewController {
        ProfileViewController(viewModel: Self.viewModel(coordinator))
    }
    
    @MainActor
    static func coordintor(_ navigationCotroller: UINavigationController) -> Coordinator {
        ProfileCoordinatorImpl(navigationController: navigationCotroller, viewController: Self.viewController)
    }
}
