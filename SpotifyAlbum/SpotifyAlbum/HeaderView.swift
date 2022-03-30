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
    
    private var imageView = UIImageView()
    
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    var isFloating = false
    
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

// MARK: - Layout()
extension HeaderView {
    private func layout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        
        widthConstraint = imageView.widthAnchor.constraint(equalToConstant: 300)
        heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 300)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            widthConstraint!,
            heightConstraint!
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 300)
    }
}

extension HeaderView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        guard
            let widthConstraint = widthConstraint,
            let heightConstraint = heightConstraint
        else { return }
        
        // Scroll
        let normalizedScroll = y / 2
        
        if normalizedScroll <= 300 {
            widthConstraint.constant = 300 - normalizedScroll
            heightConstraint.constant = 300 - normalizedScroll
        }
                
        if isFloating {
            isHidden = y > 180
        }
        
        // Alpha
        let normalizedAlpha = y / 200
        alpha = 1.0 - normalizedAlpha
    }
}
