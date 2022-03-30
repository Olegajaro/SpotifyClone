//
//  ViewController.swift
//  SpotifyAlbum
//
//  Created by Олег Федоров on 30.03.2022.
//

import UIKit

class ViewController: UIViewController {

    let songs = [
        "Overture",
        "The Grid",
        "The Son of Flynn",
        "Recognizer",
        "Armory",
        "Arena",
        "Rinzler",
        "The Game Has Changed",
        "Outlands",
        "Adagio for TRON",
        "Nocturne",
        "End of Line",
        "Derezzed",
        "Fall",
        "Solar Sailer",
        "Rectifier",
        "Disc Wars",
        "C.L.U.",
        "Arrival",
        "Flynn Lives",
        "TRON Legacy (End Titles)",
        "Finale"
    ]
    
    static let headerKind = "HeaderElementKind"
    
    private var collectionView: UICollectionView!
    
    var headerView: HeaderView?
    var floatingHeaderView = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
}

// MARK: - Layout
extension ViewController {
    private func layout() {
        // Collection View
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.register(ListCell.self,
                                forCellWithReuseIdentifier: ListCell.reuseId)
        collectionView.register(HeaderView.self,
                                forSupplementaryViewOfKind: ViewController.headerKind,
                                withReuseIdentifier: HeaderView.reuseId)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Floating header view
        floatingHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(floatingHeaderView)
    
        floatingHeaderView.track = Track(imageName: "tron")
        floatingHeaderView.isFloating = true
        
        NSLayoutConstraint.activate([
            floatingHeaderView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            floatingHeaderView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            )
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        // ListCell layout
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10,
                                                        bottom: 0, trailing: 10)
        
        // Header layout
        let headerFooterSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(300)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: ViewController.headerKind,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        songs.count
    }
    
    // ListCell
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListCell.reuseId, for: indexPath
        ) as! ListCell
        
        cell.label.text = songs[indexPath.item]
        
        return cell
    }
    
    // HeaderView
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderView.reuseId,
            for: indexPath
        ) as! HeaderView
        
        let track = Track(imageName: "tron")
        headerView.track = track
        
        self.headerView = headerView
        self.headerView?.isHidden = true
        
        return headerView
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView?.scrollViewDidScroll(scrollView)
        floatingHeaderView.scrollViewDidScroll(scrollView)
    }
}
