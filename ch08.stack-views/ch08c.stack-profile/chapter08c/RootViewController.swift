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
        static let backgroundColor = UIColor(red: 140/255, green: 213/255, blue: 251/255, alpha: 1)
        static let bioLabelFontSize: CGFloat = 17.0
        static let nameLabelFontSize: CGFloat = 24.0
    }
    
    let profileImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal))
        iv.contentMode = .top
        iv.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: ViewMetrics.nameLabelFontSize)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.text = "Sue Appleseed"
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: ViewMetrics.bioLabelFontSize)
        label.numberOfLines = 0
        label.text = "Deep sea diver. Donut maker. Tea drinker."
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, bioLabel])
        stack.axis = .vertical
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
        setupView()
    }

    private func setupView() {
        navigationItem.title = "Chapter 08c"
        view.backgroundColor = ViewMetrics.backgroundColor
        
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: ViewMetrics.rootMargins,
            leading: ViewMetrics.rootMargins,
            bottom: ViewMetrics.rootMargins,
            trailing: ViewMetrics.rootMargins)
        
        view.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            mainStack.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
            ])
    }
}

