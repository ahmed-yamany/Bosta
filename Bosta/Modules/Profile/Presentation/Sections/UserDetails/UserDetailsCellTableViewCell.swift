//
//  UserDetailsCellTableViewCell.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import UIKit

class UserDetailsCellTableViewCell: UITableViewCell, Identifiable {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!

    func update(with user: UserEntity) {
        nameLabel.text = user.name
        usernameLabel.text = user.userName
        emailLabel.text = user.email
        addressLabel.text = user.address
    }
}
