//
//  AlbumDetailsViewModel.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import Combine
import UIKit

@MainActor
protocol AlbumDetailsViewModel {
    var sectionsPublisher: AnyPublisher<[CollectionViewSection], Never> { get }
    func featchAlbumDetails()
}

/// Concrete implementation of `AlbumDetailsViewModel`.
///
/// This class handles:
/// - Fetching album photos via a use case.
/// - Building the section using `PhotosCollectionViewSection`.
/// - Publishing the sections to the view layer using Combine.
///
/// ## Memory Management
/// - The `Task` used for data fetching safely captures `self` using `[weak self]`, ensuring the
///   task does not create retain cycles if the view model is deallocated before the task completes.
final class AlbumDetailsViewModelImplementation: AlbumDetailsViewModel {
    @Published var sections: [CollectionViewSection] = []
    var sectionsPublisher: AnyPublisher<[any CollectionViewSection], Never> { $sections.eraseToAnyPublisher() }

    let useCase: AlbumDetailsUseCase
    let coordinator: AlbumDetailsCoordinator
    let album: AlbumEntity

    init(useCase: AlbumDetailsUseCase, coordinator: AlbumDetailsCoordinator, album: AlbumEntity) {
        self.useCase = useCase
        self.coordinator = coordinator
        self.album = album
    }

    /// Fetches photos for the album and prepares sections for display.
    ///
    /// ## Memory Management
    /// - This method uses a `Task` with `[weak self]` to avoid creating a retain cycle.
    /// - If the ViewModel is deallocated (e.g., the user leaves the screen), the task will automatically stop execution.
    func featchAlbumDetails() {
        Task { [weak self] in
            do {
                guard let albumId = self?.album.id else { return }
                let photos = try await self?.useCase.getAlbumDetails(id: albumId)
                guard let photos else { return }
                self?.updateSections(with: photos)
            } catch {
                print(error)
            }
        }
    }

    @MainActor
    private func updateSections(with photos: [PhotoEntity]) {
        sections = [
            PhotosCollectionViewSection(photos: photos),
        ]
    }
}
