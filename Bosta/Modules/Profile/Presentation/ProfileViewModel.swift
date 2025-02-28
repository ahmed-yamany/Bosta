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

/// Concrete implementation of `ProfileViewModel`.
///
/// This class handles:
/// - Fetching user data via a use case.
/// - Building sections using `UserDetailsSection` and `AlbumsTableViewSection`.
/// - Triggering navigation actions via a coordinator.
/// - Publishing the sections to the view layer using Combine.
///
/// This ViewModel acts as the **presentation layer glue** between the use case (business logic) and
/// the view (the screen that displays user information and albums).
///
/// ## Memory Management
/// - The `Task` used for fetching data safely captures `self` using `[weak self]` to prevent retain cycles,
///   ensuring the task does not strongly hold onto the ViewModel if the screen is dismissed.
final class ProfileViewModelImplementation: ProfileViewModel {
    // MARK: - Published Properties

    /// Holds the sections representing the content of the profile screen.
    ///
    /// These sections are emitted to the view via `sectionsPublisher`.
    @Published var sections: [any TableViewSection] = []
    var sectionsPublisher: AnyPublisher<[any TableViewSection], Never> { $sections.eraseToAnyPublisher() }

    let useCase: ProfileUseCase
    let coordinator: ProfileCoordinator

    init(useCase: ProfileUseCase, coordinator: ProfileCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }

    /// Starts fetching the user profile data, including user details and albums.
    ///
    /// The result is processed to build the appropriate `TableViewSection` instances,
    /// which are then published to the view via `sectionsPublisher`.
    ///
    /// ## Memory Management
    /// - This method uses a `Task` with `[weak self]` to avoid creating a retain cycle,
    ///   meaning the task does not hold a strong reference to the ViewModel.
    ///   (e.g., if the user leaves the screen), the task will not proceed.
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

    @MainActor
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
