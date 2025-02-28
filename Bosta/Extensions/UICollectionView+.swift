//
//  with.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//
import UIKit

public extension UICollectionView {
    /// Registers a collection view cell using its nib file.
    ///
    /// This method simplifies the registration process for cells that:
    /// - Conform to `Identifiable`, where `T.identifier` provides the reuse identifier.
    /// - Have a nib file with the **same name** as the cell class.
    ///
    /// - Parameter class: The type of the cell to register.
    func registerFromNib<T: UICollectionViewCell>(_ class: T.Type) where T: Identifiable {
        register(UINib(nibName: T.identifier, bundle: nil), forCellWithReuseIdentifier: T.identifier)
    }

    /// Dequeues a reusable collection view cell of a specific type, already casted, using its reuse identifier.
    ///
    /// This method:
    /// - Ensures **type-safety** by returning the correct cell type.
    /// - Relies on the cell conforming to `Identifiable`, so `T.identifier` is automatically used.
    ///
    /// - Parameters:
    ///   - class: The expected cell type.
    ///   - indexPath: The index path where the cell will be displayed.
    /// - Returns: An optional cell of the specified type, or `nil` if dequeuing fails.
    func dequeueReusableCell<T: UICollectionViewCell>(_ class: T.Type, for indexPath: IndexPath) -> T? where T: Identifiable {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T
    }
}
