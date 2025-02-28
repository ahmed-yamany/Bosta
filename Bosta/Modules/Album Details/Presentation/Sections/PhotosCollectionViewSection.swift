//
//  PhotosCollectionViewSection.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import UIKit

class PhotosCollectionViewSection: CollectionViewSection {
    typealias CellType = PhotoCollectionViewCell
    let spacing: CGFloat = 8
    
    let photos: [PhotoEntity]

    init(photos: [PhotoEntity]) {
        self.photos = photos
    }

    private func createSectionItem(_ layoutEnvironment: any NSCollectionLayoutEnvironment) -> NSCollectionLayoutItem {
        let leadingAndTrailingSpacing = (2 * spacing)
        let width = (layoutEnvironment.container.effectiveContentSize.width / 3) - leadingAndTrailingSpacing
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }

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
