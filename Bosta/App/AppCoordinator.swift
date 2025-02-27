//
//  AppCoordinator.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow

    var navigationController: UINavigationController

    init(scene: UIWindowScene, navigationController: UINavigationController) {
        self.navigationController = navigationController
        window = UIWindow(windowScene: scene)
        window.makeKeyAndVisible()
        window.rootViewController = navigationController
    }

    func start() {
        ProfileFactoryContainer.coordintor(navigationController).start()
    }
}
