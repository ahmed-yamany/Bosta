//
//  AlbumTableViewCell.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import UIKit

class AlbumTableViewCell: UITableViewCell, Identifiable {
    @IBOutlet var titleLabel: UILabel!

    func update(with album: AlbumEntity) {
        titleLabel.text = album.title
    }
}
