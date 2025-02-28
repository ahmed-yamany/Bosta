//
//  UsersTarget.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import Foundation
import Moya

struct UsersTarget: HTTPEndpoint {
    var path: String = "/users"
    var method: Moya.Method = .get
    var task: Moya.Task = .requestPlain
    var headers: [String: String]? = nil
}
