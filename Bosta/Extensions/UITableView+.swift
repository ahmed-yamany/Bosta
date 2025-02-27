//
//  UITableView+.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import UIKit

extension UITableView {
    func registerFromNib<T: UITableViewCell>(_ class: T.Type) where T: Identifiable {
        register(UINib(nibName: T.identifier, bundle: nil), forCellReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ class: T.Type, for indexPath: IndexPath) -> T? where T: Identifiable {
        dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
    }
}

public extension Identifiable where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}
