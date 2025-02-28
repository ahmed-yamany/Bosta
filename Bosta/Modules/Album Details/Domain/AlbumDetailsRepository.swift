//
//  AlbumDetailsRepository.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import Foundation
import Moya

protocol AlbumDetailsRepository {
    func getAlbumDetails(albumId: Int) async throws -> AlbumDetailsEntity
}

final actor AlbumDetailsRepositoryImplementation: AlbumDetailsRepository {
    let albumDetailsProvider: MoyaProvider<AlbumDetailsTarget>

    init(albumDetailsProvider: MoyaProvider<AlbumDetailsTarget>) {
        self.albumDetailsProvider = albumDetailsProvider
    }

    func getAlbumDetails(albumId: Int) async throws -> AlbumDetailsEntity {
        try await withCheckedThrowingContinuation { continuation in
            albumDetailsProvider.request(AlbumDetailsTarget(albumId: albumId), type: [Photo].self) { result in
                switch result {
                case let .success(photos):
                    continuation.resume(returning: photos.map { PhotoEntity(photo: $0) })
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
