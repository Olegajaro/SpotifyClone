//
//  HomeController.swift
//  SpotifyClone
//
//  Created by Олег Федоров on 27.03.2022.
//

import UIKit

class HomeController: UIViewController {
    
    private let menuBar = MenuBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .spotifyBlack
        
        layout()
    }
    
    private func layout() {
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(menuBar)
        
        NSLayoutConstraint.activate([
            // menuBar
            menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
}
