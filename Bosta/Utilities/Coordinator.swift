//
//  Coordinator.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//
import UIKit

/// A protocol representing a navigation coordinator responsible for managing screen flow.
/// Conforming types define how navigation starts and progresses.
@MainActor
protocol Coordinator {
    var navigationController: UINavigationController { get }

    func start()
}
