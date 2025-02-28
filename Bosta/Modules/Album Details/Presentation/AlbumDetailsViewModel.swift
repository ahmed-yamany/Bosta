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
    }

    func featchAlbumDetails() {
        Task {
            do {
                let photos = try await useCase.getAlbumDetails(id: album.id)
                sections = [
                    PhotosCollectionViewSection(photos: photos),
                ]
            } catch {
                print(error)
            }
        }
    }
}
