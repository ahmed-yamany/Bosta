//
//  ProfileCoordinatorMock.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//
@testable import Bosta
import Foundation

class ProfileCoordinatorMock: ProfileCoordinator {
    var didNavigateToAlbum: AlbumEntity?

    func navigateToAlbum(_ album: AlbumEntity) {
        didNavigateToAlbum = album
    }
}
