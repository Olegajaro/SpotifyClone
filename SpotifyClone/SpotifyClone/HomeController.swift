//
//  HomeController.swift
//  SpotifyClone
//
//  Created by Олег Федоров on 27.03.2022.
//

import UIKit

class HomeController: UIViewController {
    private let playlistCellId = "playlistId"
    
    private let menuBar = MenuBar()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PlayListCell.self,
                                forCellWithReuseIdentifier: playlistCellId)
        collectionView.backgroundColor = .spotifyBlack
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    let colors: [UIColor] = [.systemRed, .systemBlue, .systemTeal]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .spotifyBlack
        
        layout()
    }
    
    private func layout() {
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(menuBar)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            // menuBar
            menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 42),
            
            // collectionView
            collectionView.topAnchor.constraint(
                equalToSystemSpacingBelow: menuBar.bottomAnchor,
                multiplier: 2
            ),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: playlistCellId, for: indexPath
        ) as! PlayListCell
        
        cell.backgroundColor = colors[indexPath.item]
        
        return cell
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width,
                      height: collectionView.frame.height)
    }
}

