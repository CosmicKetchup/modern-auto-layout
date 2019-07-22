//
//  RootViewController.swift
//  ch08-2
//
//  Created by Matt Brown on 7/21/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private enum ViewMetrics {
        static let shareBtnFontSize: CGFloat = 24.0
    }
    
    private let sunView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "sun")?.withRenderingMode(.alwaysOriginal))
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .orange
        return iv
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: ViewMetrics.shareBtnFontSize)
        button.setTitleColor(.blue, for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return button
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sunView, shareButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = UIStackView.spacingUseSystem
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
            mainStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            mainStack.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
            ])
    }
}

