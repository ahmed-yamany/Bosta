//
//  UserDetailsSection.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//
import UIKit

class UserDetailsSection: TableViewSection {
    typealias CellType = UserDetailsCellTableViewCell

    let user: UserEntity

    init(user: UserEntity) {
        self.user = user
    }

    func registerCell(in tableView: UITableView) {
        tableView.registerFromNib(CellType.self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(CellType.self, for: indexPath) else {
            return UITableViewCell()
        }
        cell.update(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight
    }
}
