//
//  AlbumDetailsTarget.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import Foundation
import Moya

struct AlbumDetailsTarget: HTTPEndpoint {
    var path: String = "/photos"
    var method: Moya.Method = .get
    var task: Moya.Task {
        .requestParameters(parameters: ["albumId": albumId], encoding: URLEncoding.queryString)
    }
    var headers: [String: String]? = nil
    
    let albumId: Int
    
    init(albumId: Int) {
        self.albumId = albumId
    }
}
