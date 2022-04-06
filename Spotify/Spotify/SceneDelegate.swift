//
//  SceneDelegate.swift
//  Spotify
//
//  Created by Олег Федоров on 06.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        
        if AuthService.shared.isSignedIn {
            window.rootViewController = TabBarViewController()
        } else {
            let navVC = UINavigationController(
                rootViewController: WelcomeViewController()
            )
            navVC.navigationBar.prefersLargeTitles = true
            navVC.navigationItem.largeTitleDisplayMode = .always
            window.rootViewController = navVC
        }
        
        self.window = window
    }
}

