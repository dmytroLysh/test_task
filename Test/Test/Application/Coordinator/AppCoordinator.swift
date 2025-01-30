//
//  AppCoordinator.swift
//  Test
//
//  Created by Dmytro Lyshtva on 29.01.2025.
//

import UIKit

final class AppCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    private let factory: ViewControllerFactory

    init(navigationController: UINavigationController,factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func start() {
        goToPreloader()
    }

    func goToPreloader() {
        let vc = factory.makePreloaderViewController(navigation: self)
        navigationController.setViewControllers([vc], animated: true)
    }
}

extension AppCoordinator: PreloaderNavigation {
    func goToWelcomeScreen() {
        return
    }
    
    func goToMainScreen() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController, factory: factory)
        mainCoordinator.parentCoordinator = self
        addChild(mainCoordinator)
        mainCoordinator.start()
    }
}

