//
//  Photo.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import Foundation

struct Photo: Codable {
    let albumID, id: Int?
    let title: String?
    let url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
