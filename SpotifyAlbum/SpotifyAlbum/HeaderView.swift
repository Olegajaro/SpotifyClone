//
//  HeaderView.swift
//  SpotifyAlbum
//
//  Created by Олег Федоров on 30.03.2022.
//

import UIKit

struct Track {
    let imageName: String
}

class HeaderView: UICollectionReusableView {
    
    static let reuseId = "HeaderReuseId"
    
    var imageView = UIImageView()
    
    var track: Track? {
        didSet {
            guard let track = track else { return }
            let image = UIImage(named: track.imageName) ?? UIImage(named: "placeholder")!
            
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderView {
    private func layout() {
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 300)
    }
}
