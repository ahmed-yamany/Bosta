//
//  PhotoCollectionViewCell.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell, Identifiable {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    func update(with photo: PhotoEntity) {
        titleLabel.text = photo.title
        imageView.kf.setImage(with: photo.thumbnailUrl)
    }
}
