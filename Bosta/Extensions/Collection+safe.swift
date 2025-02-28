//
//  Collection+safe.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
