//
//  Collection+safe.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import Foundation

public extension Collection {
    /// Safely accesses an element at the specified index.
    ///
    /// This subscript prevents out-of-bounds crashes by:
    /// - Checking if the index is within the valid range of the collection.
    /// - Returning `nil` if the index is out of bounds, instead of causing a runtime crash.
    ///
    /// Example:
    /// ```swift
    /// let items = ["Apple", "Banana", "Orange"]
    /// let safeItem = items[safe: 5]  // Returns nil instead of crashing
    /// ```
    ///
    /// - Parameter index: The position of the element to retrieve.
    /// - Returns: The element at the specified index, or `nil` if the index is out of bounds.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
