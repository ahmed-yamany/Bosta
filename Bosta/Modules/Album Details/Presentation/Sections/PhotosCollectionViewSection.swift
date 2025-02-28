//
//  PhotosCollectionViewSection.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import UIKit

/// A section responsible for displaying a grid of photos in a collection view.
///
/// This section implements the `CollectionViewSection` protocol, making it part of the
/// Strategy Pattern used for flexible, modular collection view sections.
///
/// It registers and configures `PhotoCollectionViewCell` instances, and defines a 3-column grid layout.
class PhotosCollectionViewSection: CollectionViewSection {
    typealias CellType = PhotoCollectionViewCell
    let spacing: CGFloat = 8 /// The spacing between items in the grid.

    let photos: [PhotoEntity]

    init(photos: [PhotoEntity]) {
        self.photos = photos
    }

    // MARK: - Section Layout

    /// Creates the layout item for each photo cell.
    ///
    /// This defines the size of each cell within the section, ensuring that
    /// the cells fit within a 3-column grid with appropriate spacing.
    ///
    private func createSectionItem(_ layoutEnvironment: any NSCollectionLayoutEnvironment) -> NSCollectionLayoutItem {
        // Calculate total spacing on both sides of each item
        let leadingAndTrailingSpacing = (2 * spacing)

        // Calculate the width for each item in a 3-column grid
        // Subtract spacing to ensure proper padding between items
        let width = (layoutEnvironment.container.effectiveContentSize.width / 3) - leadingAndTrailingSpacing

        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }

    /// Creates the layout group containing the grid of items.
    ///
    /// The group size and inter-item spacing are set here, with conditional logic
    /// to use `repeatingSubitem` on iOS 16+ for simpler group creation.
    private func createSectionGroup(_ layoutEnvironment: any NSCollectionLayoutEnvironment) -> NSCollectionLayoutGroup {
        let item = createSectionItem(layoutEnvironment)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group: NSCollectionLayoutGroup

        if #available(iOS 16.0, *) {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        } else {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        }

        group.interItemSpacing = .fixed(spacing)
        return group
    }

    /// Provides the full layout for the photos section.
    ///
    /// This defines the compositional layout for the section, including:
    /// - Item sizes (each photo cell)
    /// - Grouping into rows of 3 items
    /// - Section spacing and content insets
    ///
    func sectionLayout(at index: Int, layoutEnvironment: any NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let group = createSectionGroup(layoutEnvironment)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = .init(top: 0, leading: spacing * 2, bottom: 0, trailing: 0)

        return section
    }

    func registerCell(in collectionView: UICollectionView) {
        collectionView.registerFromNib(CellType.self)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(CellType.self, for: indexPath) else {
            #if DEBUG
                fatalError("Could not dequeue cell \(CellType.self)")
            #else
                return UICollectionViewCell()
            #endif
        }
        guard let photo = photos[safe: indexPath.item] else {
            debugPrint("Failed to retrieve photo for index \(indexPath.item)")
            return UICollectionViewCell()
        }

        cell.update(with: photo)
        return cell
    }
}
