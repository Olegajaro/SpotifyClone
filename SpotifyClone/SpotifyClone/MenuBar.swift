//
//  MenuBar.swift
//  SpotifyClone
//
//  Created by Олег Федоров on 27.03.2022.
//

import UIKit

protocol MenuBarDelegate: AnyObject {
    func didSelectItemAt(index: Int)
}

class MenuBar: UIView {
    
    private let playlistsButton: UIButton!
    private let artistsButton: UIButton!
    private let albumsButton: UIButton!
    private let buttons: [UIButton]!
    
    weak var delegate: MenuBarDelegate?
    
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
        
        setAlpha(for: playlistsButton)
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
        delegate?.didSelectItemAt(index: 0)
    }
    
    @objc func artistsButtonTapped() {
        delegate?.didSelectItemAt(index: 1)
    }
    
    @objc func albumsButtonTapped() {
        delegate?.didSelectItemAt(index: 2)
    }
}

// MARK: - MenuBar Intetactions
extension MenuBar {
    
    func selectItem(at index: Int) {
        animateIndicator(to: index)
    }
    
    private func animateIndicator(to index: Int) {
        var button: UIButton
        
        switch index {
        case 0:
            button = playlistsButton
        case 1:
            button = artistsButton
        case 2:
            button = albumsButton
        default:
            button = playlistsButton
        }
        
        setAlpha(for: button)
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func setAlpha(for button: UIButton) {
        playlistsButton.alpha = 0.5
        artistsButton.alpha = 0.5
        albumsButton.alpha = 0.5
        
        button.alpha = 1.0
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
