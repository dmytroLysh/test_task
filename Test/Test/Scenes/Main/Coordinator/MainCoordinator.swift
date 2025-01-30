//
//  MainCoordinator.swift
//  Test
//
//  Created by Dmytro Lyshtva on 30.01.2025.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    private let factory: ViewControllerFactory

    init(navigationController: UINavigationController,factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        showMain()
    }
    
    private func showMain() {
        let vc = factory.makeMainViewController(navigation: self)
        navigationController.setViewControllers([vc], animated: true)
    }
    
}

extension MainCoordinator: MainNavigation {
    
}

