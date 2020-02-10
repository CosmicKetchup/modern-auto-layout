//
//  RootViewController.swift
//  chapter14f
//
//  Created by Matt Brown on 7/21/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private enum ViewMetrics {
        static let mainStackInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        static let mainStackSpacing: CGFloat = 16.0
    }
    
    private enum AnimationMetrics {
        static let duration: TimeInterval = 0.3
        static let transformScale: CGFloat = 1.25
    }
    
    private var isInitialSetupComplete = false
    
    private let heartView = UIImageView(image: UIImage(named: "heart"))
    private let starView = UIImageView(image: UIImage(named: "star"))
    private let diamondView = UIImageView(image: UIImage(named: "diamond"))
    
    private lazy var imageStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [heartView, starView, diamondView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        navigationItem.title = "Chapter 14f"
        view.backgroundColor = .white
        view.addSubview(imageStack)
        
        NSLayoutConstraint.activate([
            imageStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageStack.topAnchor.constraint(equalToSystemSpacingBelow: view.layoutMarginsGuide.topAnchor, multiplier: 2.0),
            ])
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if !isInitialSetupComplete {
            configureView(for: view.bounds.size)
            isInitialSetupComplete = true
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        if traitCollection.verticalSizeClass != newCollection.verticalSizeClass {
            animateStack(with: coordinator)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if size != view.bounds.size {
            configureView(for: size)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    private func configureView(for traitCollection: UITraitCollection) {
        switch traitCollection.verticalSizeClass {
        case .regular:
            imageStack.axis = .vertical
        default:
            imageStack.axis = .horizontal
        }
    }
    
    private func animateStack(with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.imageStack.transform = CGAffineTransform(scaleX: AnimationMetrics.transformScale, y: AnimationMetrics.transformScale)
        }) { _ in
            UIViewPropertyAnimator.runningPropertyAnimator(
                withDuration: AnimationMetrics.duration,
                delay: 0,
                options: [],
                animations: { [weak self] in
                    self?.imageStack.transform = .identity
            })
        }
    }
}

extension RootViewController {
    fileprivate func configureView(for size: CGSize) {
        if size.width > size.height {
            imageStack.axis = .horizontal
        }
        else {
            imageStack.axis = .vertical
        }
    }
}

