//
//  RootViewController.swift
//  chapter08d
//
//  Created by Matt Brown on 7/21/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
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
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chapter 08d"
        view.backgroundColor = .white
        configureImageStackAxis()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if mainStack.superview == nil {
            setupView()
        }
    }
}

extension RootViewController {
    fileprivate func setupView() {
        view.addSubview(mainStack)
        mainStack.addBackground(color: .purple, radius: 10.0)
        
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStack.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            ])
    }
    
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
        imageStack.axis = toggleSwitch.isOn ? .vertical : .horizontal
    }
}

