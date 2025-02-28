//
//  AlbumDetailsUseCase.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import Foundation

protocol AlbumDetailsUseCase {
    func getAlbumDetails(id: Int) async throws -> AlbumDetailsEntity
}

final actor AlbumDetailsUseCaseImplementation: AlbumDetailsUseCase {
    let repository: AlbumDetailsRepository
    
    init(repository: AlbumDetailsRepository) {
        self.repository = repository
    }
    
    func getAlbumDetails(id: Int) async throws -> AlbumDetailsEntity {
        try await repository.getAlbumDetails(albumId: id).shuffled()
    }
}
