//
//  SceneDelegate.swift
//  Test
//
//  Created by Dmytro Lyshtva on 29.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let navigationCon = UINavigationController.init()
        let factory = AppViewControllerFactory()
        appCoordinator = AppCoordinator(navigationController: navigationCon, factory: factory)
        appCoordinator!.start()
        window.rootViewController = navigationCon
        self.window = window
        window.overrideUserInterfaceStyle = .light
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

