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
        ProfileEntity()
    }
}
