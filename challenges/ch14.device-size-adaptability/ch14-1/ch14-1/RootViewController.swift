//
//  RootViewController.swift
//  ch14-1
//
//  Created by Matt Brown on 9/7/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let previewButton = UIButton.create(text: "Preview", bgColor: .yellow)
    private let buyButton = UIButton.create(text: "Buy", bgColor: .green)
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [previewButton, buyButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 32.0
        stack.distribution = .fillEqually
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection != previousTraitCollection {
            configureStack(for: traitCollection)
        }
    }

    private func setupView() {
        view.backgroundColor = .lightGray
        view.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            buttonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    private func configureStack(for traitCollection: UITraitCollection) {
        buttonStack.axis = traitCollection.horizontalSizeClass == .regular ? .horizontal : .vertical
    }
}

private extension UIButton {
    static func create(text buttonText: String, bgColor: UIColor) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = bgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        button.setTitle(buttonText, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 40.0)
        return button
    }
}

