//
//  AlbumDetailsEntity.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import Foundation

typealias AlbumDetailsEntity = [PhotoEntity]

struct PhotoEntity: Identifiable {
    var id = UUID()
    let title: String
    let url: URL?
    let thumbnailUrl: URL?
}

extension PhotoEntity {
    init(photo: Photo) {
        title = photo.title ?? ""
        url = URL(string: photo.url ?? "")
        thumbnailUrl = URL(string: photo.thumbnailURL ?? "")
    }
}
