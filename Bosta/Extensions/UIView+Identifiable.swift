//
//  UIView+Identifiable.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import UIKit

public extension Identifiable where Self: UIView {
    /// Provides a default `identifier` for any `UIView` conforming to `Identifiable`.
    ///
    /// The `identifier` is automatically derived from the class name
    /// ensuring that the identifier always matches the name of the view class.
    ///
    /// This is particularly useful for:
    /// - `UITableViewCell`
    /// - `UICollectionViewCell`
    /// - `UICollectionReusableView`
    /// - Custom views that are reused or registered dynamically
    ///
    /// Example:
    /// ```swift
    /// final class AlbumTableViewCell: UITableViewCell, Identifiable {}
    /// print(AlbumTableViewCell.identifier)
    /// ```
    static var identifier: String {
        return String(describing: self)
    }
}
