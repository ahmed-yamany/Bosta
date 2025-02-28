//
//  ProfileRepository.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import Foundation
import Moya

protocol ProfileRepository {
    func getUsersDetails() async throws -> [UserEntity]
    func getAlbums(for userId: Int) async throws -> [AlbumEntity]
}

final actor ProfileRepositoryImplementation: ProfileRepository {
    let usersProvider: MoyaProvider<UsersTarget>
    let albumsProvider: MoyaProvider<AlbumsTarget>

    init(usersProvider: MoyaProvider<UsersTarget>, albumsProvider: MoyaProvider<AlbumsTarget>) {
        self.usersProvider = usersProvider
        self.albumsProvider = albumsProvider
    }

    func getUsersDetails() async throws -> [UserEntity] {
        try await withCheckedThrowingContinuation { continuation in
            usersProvider.request(UsersTarget(), type: [User].self) { result in
                switch result {
                case let .success(users):
                    continuation.resume(returning: users.map { UserEntity($0) })
                case let .failure(failure):
                    continuation.resume(throwing: failure)
                }
            }
        }
    }

    func getAlbums(for userId: Int) async throws -> [AlbumEntity] {
        try await withCheckedThrowingContinuation { continuation in
            albumsProvider.request(AlbumsTarget(), type: [Album].self) { result in
                switch result {
                case let .success(albums):
                    continuation.resume(returning: albums.map { AlbumEntity($0) })
                case let .failure(failure):
                    continuation.resume(throwing: failure)
                }
            }
        }
    }
}
