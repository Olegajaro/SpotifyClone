//
//  AppDelegate.swift
//  SpotifyClone
//
//  Created by Олег Федоров on 26.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .spotifyBlack
        
        let navigationContoller = UINavigationController(
            rootViewController: TitleBarController()
        )
        window?.rootViewController = navigationContoller
        
//        window?.rootViewController = HomeController()
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .spotifyBlack
        
        return true
    }
}

