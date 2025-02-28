//
//  User.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

struct User: Codable {
    let id: Int?
    let name, username, email: String?
    let address: Address?
}

struct Address: Codable {
    let street, suite, city, zipcode: String?
    let geo: Geo?
}

struct Geo: Codable {
    let lat, lng: String?
}

struct Company: Codable {
    let name, catchPhrase, bs: String?
}
