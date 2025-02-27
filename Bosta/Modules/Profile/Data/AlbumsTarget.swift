//
//  AlbumsTarget.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//
import Foundation
import Moya

struct AlbumsTarget: HTTPEndpoint {
    var path: String = "/albums"
    var method: Moya.Method = .get
    var task: Moya.Task = .requestPlain
    var headers: [String: String]? = nil
}
