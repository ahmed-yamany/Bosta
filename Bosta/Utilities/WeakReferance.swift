//
//  WeakReferance.swift
//  Bosta
//
//  Created by Ahmed Yamany on 01/04/2025.
//
import Foundation

final class WeakReferance<T: AnyObject> {
    weak var object: T?

    init(object: T) {
        self.object = object
    }
}
