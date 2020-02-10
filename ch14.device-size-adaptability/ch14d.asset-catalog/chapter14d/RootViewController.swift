//
//  RootViewController.swift
//  chapter14d
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
    
    private let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(switchToggled(_:)), for: .touchUpInside)
        toggle.isOn = true
        return toggle
    }()
    
    private let heartView = UIImageView(image: UIImage(named: "heart"))
    private let starView = UIImageView(image: UIImage(named: "star"))
    private let diamondView = UIImageView(image: UIImage(named: "diamond"))
    
    private lazy var imageStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [heartView, starView, diamondView])
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [toggleSwitch, imageStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.spacing = ViewMetrics.mainStackSpacing
        stack.directionalLayoutMargins = ViewMetrics.mainStackInsets
        stack.isLayoutMarginsRelativeArrangement = true
        stack.axis = .vertical
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        navigationItem.title = "Chapter 14d"
        view.backgroundColor = .white
        configureImageStackAxis()
        view.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStack.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
            ])
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        if traitCollection.verticalSizeClass != newCollection.verticalSizeClass {
            animateStack(with: coordinator)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.verticalSizeClass != traitCollection.verticalSizeClass {
            configureView(for: traitCollection)
        }
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
    @objc fileprivate func switchToggled(_ sender: UISwitch) {
        UIViewPropertyAnimator(
            duration: 0.5,
            dampingRatio: 0.3,
            animations: { [weak self] in
                self?.configureImageStackAxis()
        }).startAnimation()
    }
    
    fileprivate func configureImageStackAxis() {
        if let lastStackImage = imageStack.arrangedSubviews.last {
            lastStackImage.isHidden = !toggleSwitch.isOn
        }
    }
}

