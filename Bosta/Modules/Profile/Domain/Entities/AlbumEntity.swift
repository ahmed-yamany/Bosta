//
//  AlbumEntity.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//
import Foundation

struct AlbumEntity {
    let id: Int
    let title: String
}

extension AlbumEntity {
    init(_ album: Album) {
        self.id = album.id ?? 1
        self.title = album.title ?? ""
    }
}
