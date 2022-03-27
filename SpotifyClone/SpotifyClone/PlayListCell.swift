//
//  PlayListCell.swift
//  SpotifyClone
//
//  Created by Олег Федоров on 27.03.2022.
//

import UIKit

let trackCellHeight: CGFloat = 72

// MARK: - Playlists Cell
class PlayListCell: UICollectionViewCell {
    
    let trackCellId = "trackId"
    
    var tracks: [Track]?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(TrackCell.self,
                                forCellWithReuseIdentifier: trackCellId)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .spotifyBlack
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension PlayListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let tracks = tracks else { return 0 }
        return tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: trackCellId, for: indexPath
        ) as! TrackCell
        
        cell.track = tracks?[indexPath.item]
        
        return cell
    }
}

extension PlayListCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: frame.width, height: trackCellHeight)
    }
}

// MARK: - Track
struct Track {
    let imageName: String
    let title: String
    let artist: String
}

// MARK: - Track Cell
class TrackCell: UICollectionViewCell {
    
    let stackView = makeStackView(axis: .vertical)
    var imageView = UIImageView()
    var titleLabel = UILabel()
    var subtitleLable = UILabel()
    
    var track: Track? {
        didSet {
            guard let track = track else { return }
            let image = UIImage(named: track.imageName) ?? UIImage(named: "placeholder")!
            
            imageView.image = image
            titleLabel.text = track.title
            subtitleLable.text = track.artist
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body).bold()
        
        subtitleLable.translatesAutoresizingMaskIntoConstraints = false
        subtitleLable.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitleLable.alpha = 0.7
        
        stackView.spacing = 6
    }
    
    private func layout() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLable)
        
        addSubview(imageView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: trackCellHeight),
            imageView.widthAnchor.constraint(equalToConstant: trackCellHeight),
            
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(
                equalToSystemSpacingAfter: imageView.trailingAnchor,
                multiplier: 2
            ),
            trailingAnchor.constraint(
                equalToSystemSpacingAfter: stackView.trailingAnchor,
                multiplier: 3
            )
        ])
    }
}
