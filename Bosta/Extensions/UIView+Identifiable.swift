//
//  UIView+Identifiable.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import UIKit

public extension Identifiable where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}
