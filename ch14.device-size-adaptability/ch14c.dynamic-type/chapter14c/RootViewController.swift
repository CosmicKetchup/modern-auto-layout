//
//  RootViewController.swift
//  chapter14c
//
//  Created by Matt Brown on 2/9/20.
//  Copyright © 2020 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let settingToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.setContentCompressionResistancePriority(.required, for: .horizontal)
        toggle.setContentHuggingPriority(.required, for: .horizontal)
        return toggle
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.text = "Larger Accessibility Sizes"
        return label
    }()
    
    private let stackBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var settingStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, settingToggle])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.preservesSuperviewLayoutMargins = true
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.text = "Apps that support Dynamic Type will adjust to your preferred reading size below"
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.preservesSuperviewLayoutMargins = true
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 8, bottom: 20, trailing: 8)
        view.preservesSuperviewLayoutMargins = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        navigationItem.title = "Larger Text"
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .lightGray
        
        settingStack.insertSubview(stackBackground, at: 0)
        [settingStack, descriptionLabel].forEach { containerView.addSubview($0) }
        [containerView].forEach { scrollView.addSubview($0) }
        [scrollView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            stackBackground.topAnchor.constraint(equalTo: settingStack.topAnchor),
            stackBackground.leadingAnchor.constraint(equalTo: settingStack.leadingAnchor),
            stackBackground.bottomAnchor.constraint(equalTo: settingStack.bottomAnchor),
            stackBackground.trailingAnchor.constraint(equalTo: settingStack.trailingAnchor),
            
            settingStack.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor),
            settingStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            settingStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: settingStack.bottomAnchor, multiplier: 1.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leadingAnchor),
            containerView.layoutMarginsGuide.bottomAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: descriptionLabel.bottomAnchor, multiplier: 1.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            scrollView.frameLayoutGuide.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        
        configureView(for: traitCollection)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory {
            configureView(for: traitCollection)
        }
    }
    
    private func configureView(for traitCollection: UITraitCollection) {
        if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
            settingStack.axis = .vertical
            settingStack.alignment = .leading
        }
        else {
            settingStack.axis = .horizontal
            settingStack.alignment = .center
        }
    }
}

