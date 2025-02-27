//
//  ProfileFactoryContainer.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import UIKit

struct ProfileFactoryContainer {
    private static func repository() -> ProfileRepository {
        ProfileRepositoryImplementation()
    }

    private static func useCase() -> ProfileUseCase {
        ProfileUseCaseImplementation(repository: Self.repository())
    }

    @MainActor
    private static func viewModel() -> ProfileViewModel {
        ProfileViewModelImplementation(useCase: Self.useCase())
    }

    @MainActor
    static private func viewController() -> UIViewController {
        ProfileViewController(viewModel: Self.viewModel())
    }
    
    @MainActor
    static func coordintor(_ navigationCotroller: UINavigationController) -> Coordinator {
        ProfileCoordinatorImpl(navigationController: navigationCotroller, viewController: Self.viewController())
    }
}
