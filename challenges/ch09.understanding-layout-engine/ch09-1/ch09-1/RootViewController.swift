//
//  RootViewController.swift
//  ch09-1
//
//  Created by Matt Brown on 7/27/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private var isFastState = false
    
    private let redButton: UIButton = {
        let button = UIButton(text: "Slow", bgColor: .red)
        button.tag = 1
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private let greenButton: UIButton = {
        let button = UIButton(text: "Fast", bgColor: .green)
        button.tag = 2
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [redButton, greenButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = UIStackView.spacingUseSystem
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    private lazy var redHeight4x = redButton.heightAnchor.constraint(equalToConstant: greenButton.intrinsicContentSize.height * 4.0)
    private lazy var greenHeight4x = greenButton.heightAnchor.constraint(equalToConstant: redButton.intrinsicContentSize.height * 4.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(buttonStack)
        
        configureButtonHeights()
        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            buttonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
}

extension RootViewController {
    @objc fileprivate func buttonTapped(_ sender: UIButton) {
        [redButton, greenButton].forEach({ $0.isUserInteractionEnabled = false })
        isFastState = sender.tag % 2 == 0
        
        UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) { [weak self] in
            self?.configureButtonHeights()
            self?.view.layoutIfNeeded()
        }.startAnimation()
        
        [redButton, greenButton].forEach({ $0.isUserInteractionEnabled = true })
    }
    
    fileprivate func configureButtonHeights() {
        redHeight4x.isActive = !isFastState
        greenHeight4x.isActive = isFastState
    }
}

private extension UIButton {
    convenience init(text buttonText: String, bgColor: UIColor) {
        self.init()
        backgroundColor = bgColor
        setTitle(buttonText, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 24.0)
        
        let buttonInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        contentEdgeInsets = buttonInsets
    }
}

