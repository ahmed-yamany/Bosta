//
//  Coordinator.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//
import UIKit

@MainActor
protocol Coordinator {
    var navigationController: UINavigationController { get }

    func start()
}
