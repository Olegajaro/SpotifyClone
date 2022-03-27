//
//  ViewController.swift
//  SpotifyClone
//
//  Created by Олег Федоров on 26.03.2022.
//

import UIKit

class TitleBarController: UIViewController {

    private var musicBarButtonItem: UIBarButtonItem!
    private var podcastBatButtonItem: UIBarButtonItem!
    
    private let container = Container()
    
    private let viewControllers: [UIViewController] = [
        HomeController(),
        HomeController()
    ]
    
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
        setupView()
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItems = [musicBarButtonItem, podcastBatButtonItem]
        
        // hide bottom shade pixel
        let img = UIImage()
        navigationController?.navigationBar.shadowImage = img
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setupView() {
        guard let containerView = container.view else { return }
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemBackground
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(
                equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor,
                multiplier: 2
            ),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
        
        musicTapped()
    }
}

// MARK: - Actions
extension TitleBarController {
    @objc private func musicTapped() {
        // show music viewController
        if container.children.first == viewControllers[0] { return }
        
        container.add(viewControllers[0])
        
        animateTransition(
            fromVC: viewControllers[1],
            toVC: viewControllers[0]
        ) { [weak self] _ in
            self?.viewControllers[1].remove()
        }
        
        UIView.animate(withDuration: 0.5) {
            self.musicBarButtonItem.customView?.alpha = 1.0
            self.podcastBatButtonItem.customView?.alpha = 0.5
        }
    }
    
    @objc private func podcastTapped() {
        // show podcast viewController
        if container.children.first == viewControllers[1] { return }
        
        container.add(viewControllers[1])
        
        animateTransition(
            fromVC: viewControllers[0],
            toVC: viewControllers[1]
        ) { [weak self] _ in
            self?.viewControllers[0].remove()
        }
        
        UIView.animate(withDuration: 0.5) {
            self.musicBarButtonItem.customView?.alpha = 0.5
            self.podcastBatButtonItem.customView?.alpha = 1.0
        }
    }
}

// MARK: - Animate
extension TitleBarController {
    private func animateTransition(
        fromVC: UIViewController,
        toVC: UIViewController,
        completion: @escaping (Bool) -> Void
    ) {
        guard
            let fromView = fromVC.view,
            let fromIndex = getIndex(forViewController: fromVC),
            let toView = toVC.view,
            let toIndex = getIndex(forViewController: toVC)
        else { return }
        
        let frame = fromVC.view.frame
        var fromFrameEnd = frame
        var toFrameStart = frame
        
        fromFrameEnd.origin.x = toIndex > fromIndex
        ? frame.origin.x - frame.width
        : frame.origin.x + frame.width
        
        toFrameStart.origin.x = toIndex > fromIndex
        ? frame.origin.x + frame.width
        : frame.origin.x - frame.width
        
        toView.frame = toFrameStart
        
        UIView.animate(withDuration: 0.5) {
            fromView.frame = fromFrameEnd
            toView.frame = frame
        } completion: { success in
            completion(success)
        }
    }
    
    private func getIndex(forViewController vc: UIViewController) -> Int? {
        for (index, thisVC) in viewControllers.enumerated() {
            if thisVC == vc {
                return index
            }
        }
        
        return nil
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
