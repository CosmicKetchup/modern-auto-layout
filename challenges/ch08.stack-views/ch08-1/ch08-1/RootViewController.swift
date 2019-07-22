//
//  RootViewController.swift
//  ch08-1
//
//  Created by Matt Brown on 7/21/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Engine Power"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let lowButton = UIButton(text: "Low", color: .red)
    private let mediumButton = UIButton(text: "Medium", color: .yellow)
    private let highButton = UIButton(text: "High", color: .green)
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerLabel, lowButton, mediumButton, highButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}

private extension UIButton {
    convenience init(text buttonText: String, color buttonColor: UIColor) {
        self.init()
        setTitle(buttonText, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
        backgroundColor = buttonColor
    }
}
