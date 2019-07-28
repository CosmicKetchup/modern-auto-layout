//
//  RootViewController.swift
//  chapter09a
//
//  Created by Matt Brown on 7/27/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private enum AnimationMetrics {
        static let verticalOffset: CGFloat = -200.0
        static let animDuration: TimeInterval = 1.0
        static let animDelay: TimeInterval = 1.0
        static let animDamping: CGFloat = 4.0
    }
    
    private let redButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var redYConstraint = NSLayoutConstraint(
        item: redButton,
        attribute: .centerY,
        relatedBy: .equal,
        toItem: view,
        attribute: .centerY,
        multiplier: 1.0,
        constant: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redYConstraint.constant = AnimationMetrics.verticalOffset
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateButton(withDuration: AnimationMetrics.animDuration, damping: AnimationMetrics.animDamping, delay: AnimationMetrics.animDelay)
    }

    private func setupView() {
        view.backgroundColor = .yellow
        
        view.addSubview(redButton)
        
        NSLayoutConstraint.activate([
            redButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            redYConstraint
            ])
    }
}

extension RootViewController {
    fileprivate func animateButton(withDuration duration: TimeInterval, damping: CGFloat, delay: TimeInterval = 0) {
        redYConstraint.constant = 0
        
        let animator = UIViewPropertyAnimator(
            duration: duration,
            dampingRatio: damping,
            animations: { [weak self] in
                self?.view.layoutIfNeeded()
        })
        
        animator.startAnimation(afterDelay: delay)
    }
}

