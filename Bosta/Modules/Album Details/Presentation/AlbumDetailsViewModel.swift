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
}

@MainActor
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

        Task {
            do {
                let photos = try await useCase.getAlbumDetails(id: album.id)
                sections = [
                    PhotosCollectionViewSection(photos: photos)
                ]
            } catch {
                print(error)
            }
        }
    }
}
