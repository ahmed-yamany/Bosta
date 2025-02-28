//
//  ProfileUseCase.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import Foundation

protocol ProfileUseCase {
    func fetchProfile() async throws -> ProfileEntity
}

final actor ProfileUseCaseImplementation: ProfileUseCase {
    let repository: ProfileRepository

    init(repository: ProfileRepository) {
        self.repository = repository
    }

    func fetchProfile() async throws -> ProfileEntity {
        let users = try await repository.getUsersDetails()
        let user = users.first(where: { $0.userName.contains("Bret") })

        guard let user else {
            throw NSError(domain: "Search Error: Did not find the user", code: 0)
        }
        
        let albums = try await repository.getAlbums(for: 1)
        
        return ProfileEntity(user: user, albums: albums)
    }
}
