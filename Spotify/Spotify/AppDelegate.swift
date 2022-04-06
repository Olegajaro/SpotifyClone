//
//  AppDelegate.swift
//  Spotify
//
//  Created by Олег Федоров on 06.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
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
        
        return true
    }
}

