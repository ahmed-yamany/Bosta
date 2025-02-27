//
//  HTTPEndpoint.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//
import Foundation
import Moya

protocol HTTPEndpoint: TargetType {
}

extension HTTPEndpoint {
    var baseURL: URL {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else {
            fatalError("Invalid baseURL: \(#file):\(#line)")
        }

        return url
    }
}
