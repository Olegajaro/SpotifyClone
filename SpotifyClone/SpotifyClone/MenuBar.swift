//
//  MenuBar.swift
//  SpotifyClone
//
//  Created by Олег Федоров on 27.03.2022.
//

import UIKit

class MenuBar: UIView {
    
    let playlistsButton: UIButton!
    let artistsButton: UIButton!
    let albumsButton: UIButton!
    let buttons: [UIButton]!
    
    override init(frame: CGRect) {
        playlistsButton = makeButton(withText: "Playlists")
        artistsButton = makeButton(withText: "Artists")
        albumsButton = makeButton(withText: "Albums")
        
        buttons = [playlistsButton, artistsButton, albumsButton]
        
        super.init(frame: .zero)
        
        playlistsButton.addTarget(self,
                                  action: #selector(playlistsButtonTapped),
                                  for: .primaryActionTriggered)
        artistsButton.addTarget(self,
                                  action: #selector(artistsButtonTapped),
                                  for: .primaryActionTriggered)
        albumsButton.addTarget(self,
                                  action: #selector(albumsButtonTapped),
                                  for: .primaryActionTriggered)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(playlistsButton)
        addSubview(artistsButton)
        addSubview(albumsButton)
        
        NSLayoutConstraint.activate([
            playlistsButton.topAnchor.constraint(equalTo: topAnchor),
            playlistsButton.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 16
            ),
            artistsButton.topAnchor.constraint(equalTo: topAnchor),
            artistsButton.leadingAnchor.constraint(
                equalTo: playlistsButton.trailingAnchor, constant: 32
            ),
            albumsButton.topAnchor.constraint(equalTo: topAnchor),
            albumsButton.leadingAnchor.constraint(
                equalTo: artistsButton.trailingAnchor, constant: 32
            )
        ])
    }
}

// MARK: - Actions
extension MenuBar {
    @objc func playlistsButtonTapped() {
        
    }
    
    @objc func artistsButtonTapped() {
        
    }
    
    @objc func albumsButtonTapped() {
        
    }
}

func makeButton(withText text: String) -> UIButton {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .label
    button.setTitle(text, for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    
    return button
}
