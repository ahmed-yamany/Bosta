//
//  SceneDelegate.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigationController = UINavigationController()
        coordinator = AppCoordinator(scene: windowScene, navigationController: navigationController)
        coordinator?.start()
    }
}
