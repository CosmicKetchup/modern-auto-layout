//
//  RootViewController.swift
//  ch08-3
//
//  Created by Matt Brown on 7/21/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = false
        toggle.addTarget(self, action: #selector(switchTapped(_:)), for: .touchUpInside)
        return toggle
    }()
    
    private let leftKeyLabel = UILabel(text: "1A")
    private let midKeyLabel = UILabel(text: "2BZ")
    private let rightKeyLabel = UILabel(text: "3Z")
    
    private let keyCoverView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var keyStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftKeyLabel, midKeyLabel, rightKeyLabel])
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [toggleSwitch, keyStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 16
        stack.axis = .vertical
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stack.alignment = .center
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Secret Code"
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
        
        let stackBackgroundColor = UIView()
        stackBackgroundColor.translatesAutoresizingMaskIntoConstraints = false
        stackBackgroundColor.backgroundColor = .purple
        mainStack.insertSubview(stackBackgroundColor, at: 0)
        mainStack.addSubview(keyCoverView)
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            mainStack.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            
            stackBackgroundColor.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            stackBackgroundColor.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            stackBackgroundColor.topAnchor.constraint(equalTo: mainStack.topAnchor),
            stackBackgroundColor.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor),
            
            keyCoverView.leadingAnchor.constraint(equalTo: keyStack.leadingAnchor),
            keyCoverView.trailingAnchor.constraint(equalTo: keyStack.trailingAnchor),
            keyCoverView.topAnchor.constraint(equalTo: keyStack.topAnchor),
            keyCoverView.bottomAnchor.constraint(equalTo: keyStack.bottomAnchor)
            ])
    }
    
    @objc fileprivate func switchTapped(_ sender: UISwitch) {
        UIViewPropertyAnimator(
            duration: 0.5,
            curve: .linear,
            animations: { [weak self] in
                if let toggleValue = self?.toggleSwitch.isOn {
                    self?.keyCoverView.backgroundColor = toggleValue ? .clear : .yellow
                }
        }).startAnimation()
    }
}

private extension UILabel {
    convenience init(text labelText: String) {
        self.init()
        text = labelText
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 40)
        backgroundColor = .yellow
    }
}
