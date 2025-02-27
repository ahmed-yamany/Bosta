//
//  MoyaProvider+requestAsync.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import Foundation
import Moya

extension MoyaProvider {
    func request<ResponseType: Codable>(
        _ target: Target,
        type: ResponseType.Type,
        completion: @escaping (Result<ResponseType, Error>) -> Void
    ) {
        request(target) { result in
            switch result {
            case let .success(response):
                do {
                    // Attempt to decode the response data into the specified type
                    let responseData = try JSONDecoder().decode(ResponseType.self, from: response.data)
                    completion(.success(responseData))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
