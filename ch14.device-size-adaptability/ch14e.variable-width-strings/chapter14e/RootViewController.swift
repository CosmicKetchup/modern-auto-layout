//
//  RootViewController.swift
//  chapter14e
//
//  Created by Matt Brown on 2/10/20.
//  Copyright © 2020 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    fileprivate enum ViewMetrics {
        static let backgroundColor = UIColor.yellow
        static let buttonInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    private let abortButton = UIButton(bgColor: .red)
    private let startButton = UIButton(bgColor: .green)
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [abortButton, startButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = UIStackView.spacingUseSystem
        stack.distribution = .fillEqually
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = ViewMetrics.backgroundColor
        abortButton.setTitle(NSLocalizedString("Abort", comment: "Abort Button"), for: .normal)
        startButton.setTitle(NSLocalizedString("Start", comment: "Start Button"), for: .normal)
        
        [buttonStack].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            buttonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            view.layoutMarginsGuide.trailingAnchor.constraint(equalTo: buttonStack.trailingAnchor),
            ])
    }
}

private extension UIButton {
    convenience init(bgColor: UIColor) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = bgColor
        contentEdgeInsets = RootViewController.ViewMetrics.buttonInsets
        
        setTitleColor(.black, for: .normal)
        titleLabel?.textAlignment = .center
        titleLabel?.font = .systemFont(ofSize: 17.0)
    }
}
