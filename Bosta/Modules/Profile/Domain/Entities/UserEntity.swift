//
//  UserEntity.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//
import Foundation

struct UserEntity {
    let name: String
    let userName: String
    let email: String
    let address: String
}

extension UserEntity {
    init(_ user: User) {
        name = user.name ?? "-"
        userName = "@\(user.username ?? "")"
        email = user.email ?? "-"
        address = "\(user.address?.street ?? ""), \(user.address?.city ?? ""), \(user.address?.zipcode ?? "")"
    }
}
