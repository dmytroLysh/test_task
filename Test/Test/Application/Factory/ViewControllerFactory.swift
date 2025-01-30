//
//  ViewControllerFactory.swift
//  Test
//
//  Created by Dmytro Lyshtva on 29.01.2025.
//

import UIKit

protocol ViewControllerFactory {
    
    func makePreloaderViewController(navigation: PreloaderNavigation) -> PreloaderViewController
    func makeMainViewController(navigation: MainNavigation) -> MainViewController
    
}

final class AppViewControllerFactory: ViewControllerFactory {
    
    func makePreloaderViewController(navigation: PreloaderNavigation) -> PreloaderViewController {
        let viewModel = PreloaderViewModel(navigation: navigation)
        return PreloaderViewController(viewModel: viewModel)
    }
    
    func makeMainViewController(navigation: MainNavigation) -> MainViewController {
        let apiClient = APIService()
        let mainService = MainAPIService(apiClient: apiClient)
        let viewModel = MainViewModel(navigation: navigation,service:mainService)
        return MainViewController(viewModel: viewModel)
    }
}
