//
//  RootViewController.swift
//  chapter08c
//
//  Created by Matt Brown on 7/21/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private enum ViewMetrics {
        static let rootMargins: CGFloat = 20.0
    }
    
    let profileImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal))
        iv.contentMode = .top
        iv.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.text = "Sue Appleseed"
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.text = "Deep sea diver. Donut maker. Tea drinker."
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, bioLabel])
        stack.axis = .vertical
//        stack.alignment = .fill // default value for .alignment property
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileImageView, labelStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chapter 08c"
        view.backgroundColor = UIColor(red: 140/255, green: 213/255, blue: 251/255, alpha: 1)
        
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: ViewMetrics.rootMargins,
            leading: ViewMetrics.rootMargins,
            bottom: ViewMetrics.rootMargins,
            trailing: ViewMetrics.rootMargins)
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
            mainStack.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
            ])
    }
}

