//
//  AlbumDetailsUseCase.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import Foundation

protocol AlbumDetailsUseCase {
    
}

final actor AlbumDetailsImplementation: AlbumDetailsUseCase {
    let repository: AlbumDetailsRepository
    
    init(repository: AlbumDetailsRepository) {
        self.repository = repository
    }
}
