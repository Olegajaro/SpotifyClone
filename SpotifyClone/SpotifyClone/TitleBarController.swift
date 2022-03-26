//
//  ViewController.swift
//  SpotifyClone
//
//  Created by Олег Федоров on 26.03.2022.
//

import UIKit

class MusicViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
    }
}

class PodcastViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow
    }
}

class TitleBarController: UIViewController {

    private var musicBarButtonItem: UIBarButtonItem!
    private var podcastBatButtonItem: UIBarButtonItem!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        musicBarButtonItem = makeBarButtonItem(
            text: "Music",
            selector: #selector(musicTapped)
        )
        podcastBatButtonItem = makeBarButtonItem(
            text: "  Podcasts",
            selector: #selector(podcastTapped)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItems = [musicBarButtonItem, podcastBatButtonItem]
    }
}

// MARK: - Actions
extension TitleBarController {
    @objc private func musicTapped() {
        
    }
    
    @objc private func podcastTapped() {
        
    }
}

// MARK: - Factories
extension TitleBarController {
    private func makeBarButtonItem(text: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: selector, for: .primaryActionTriggered)
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.preferredFont(
                forTextStyle: .largeTitle
            ).bold(),
            NSAttributedString.Key.foregroundColor: UIColor.label
        ]
        
        let attributedText = NSMutableAttributedString(string: text,
                                                       attributes: attributes)
        
        button.setAttributedTitle(attributedText, for: .normal)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        
        return barButtonItem
    }
}
