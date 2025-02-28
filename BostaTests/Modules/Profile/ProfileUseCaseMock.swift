//
//  ProfileUseCaseMock.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//
@testable import Bosta
import Foundation

class ProfileUseCaseMock: ProfileUseCase {
    var fetchProfileResult: Result<ProfileEntity, Error> = .failure(MockError.generic)

    func fetchProfile() async throws -> ProfileEntity {
        switch fetchProfileResult {
        case let .success(profile):
            return profile
        case let .failure(error):
            throw error
        }
    }

    enum MockError: Error {
        case generic
    }
}
