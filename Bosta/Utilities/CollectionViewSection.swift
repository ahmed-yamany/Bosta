//
//  CollectionViewSection.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import UIKit

protocol CollectionViewSectionDelegate {
}

protocol CollectionViewSectionDataSource {
    func registerCell(in collectionView: UICollectionView)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

/// A combined protocol representing a **complete section strategy** for a collection view.
///
/// This defines:
/// - How cells are registered, created, and displayed (data strategy).
/// - How the section lays out its items (layout strategy).
/// - How user interactions are handled (behavior strategy — currently empty but extendable).
///
/// By combining all these responsibilities, the section can fully encapsulate its behavior, making it
/// interchangeable and modular, following the **Strategy Design Pattern**.
protocol CollectionViewSection: CollectionViewSectionDelegate, CollectionViewSectionDataSource {
    /// Provides the compositional layout for this section.
    ///
    /// This defines the **layout strategy** for the section, allowing each section to customize its appearance,
    ///
    /// - Parameters:
    ///   - index: The section index.
    ///   - layoutEnvironment: The environment that can be used to adjust the layout based on context (e.g., size classes).
    /// - Returns: A fully configured `NSCollectionLayoutSection`.
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection
}
