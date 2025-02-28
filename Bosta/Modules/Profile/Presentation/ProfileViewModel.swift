//
//  ProfileViewModel.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import Combine
import UIKit

@MainActor
protocol ProfileViewModel {
    var sectionsPublisher: AnyPublisher<[TableViewSection], Never> { get }
    func featchUserProfile()
}

@MainActor
final class ProfileViewModelImplementation: ProfileViewModel {
    @Published var sections: [any TableViewSection] = []
    var sectionsPublisher: AnyPublisher<[any TableViewSection], Never> { $sections.eraseToAnyPublisher() }

    let useCase: ProfileUseCase
    let coordinator: ProfileCoordinator

    init(useCase: ProfileUseCase, coordinator: ProfileCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }

    func featchUserProfile() {
        Task { [weak self] in
            do {
                let profile = try await self?.useCase.fetchProfile()
                
                guard let profile else {
                    debugPrint("Failed to fetch profile, for class deallocated")
                    return
                }
                
                self?.updateSections(with: profile)

            } catch {
                print(error)
            }
        }
    }

    private func updateSections(with profile: ProfileEntity) {
        sections = [
            UserDetailsSection(user: profile.user),
            createAlbumSection(albums: profile.albums),
        ]
    }

    private func createAlbumSection(albums: [AlbumEntity]) -> AlbumsTableViewSection {
        AlbumsTableViewSection(albums: albums, onSelectAlbum: { [weak self] album in
            self?.coordinator.navigateToAlbum(album)
        })
    }
}
