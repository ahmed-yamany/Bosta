//
//  AlbumDetailsViewModel.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import Foundation

@MainActor
protocol AlbumDetailsViewModel {
}

@MainActor
final class AlbumDetailsViewModelImplementation: AlbumDetailsViewModel {
    let useCase: AlbumDetailsUseCase
    let coordinator: AlbumDetailsCoordinator

    init(useCase: AlbumDetailsUseCase, coordinator: AlbumDetailsCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
}
