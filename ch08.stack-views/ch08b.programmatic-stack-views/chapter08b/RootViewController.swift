//
//  RootViewController.swift
//  chapter08b
//
//  Created by Matt Brown on 7/21/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private enum ViewMetrics {
        static let headerLabelFontSize: CGFloat = 24.0
    }
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Pick A Color"
        label.font = UIFont.systemFont(ofSize: ViewMetrics.headerLabelFontSize)
        return label
    }()
    
    private let redButton = UIButton(text: "Red", color: .red)
    private let greenButton = UIButton(text: "Green", color: .green)
    private let blueButton = UIButton(text: "Blue", color: .blue)
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [redButton, greenButton, blueButton])
        stack.distribution = .fillEqually
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerLabel, buttonStack])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = UIStackView.spacingUseSystem
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}

private extension UIButton {
    convenience init(text buttonText: String, color textColor: UIColor) {
        self.init()
        setTitle(buttonText, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 24)
    }
}

