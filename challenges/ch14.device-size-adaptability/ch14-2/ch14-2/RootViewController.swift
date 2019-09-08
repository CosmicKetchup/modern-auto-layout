//
//  RootViewController.swift
//  ch14-2
//
//  Created by Matt Brown on 9/7/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

private let titleText = "Weather For Today"
private let summaryText = "Today will be hot and sunny. If you are going out you will need a hat and sunglasses. There is a small chance of a heavy thunderstorm in the afternoon that could cause severe flooding so you may also want to take a boat."

class RootViewController: UIViewController {
    
    private let sunImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "sun"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let titleLabel = UILabel(text: titleText, style: .title1, alignment: .center)
    private let summaryLabel = UILabel(text: summaryText, style: .body, alignment: .left)
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        [sunImage, titleLabel, summaryLabel].forEach({ view.addSubview($0) })
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        return view
    }()
    
    private lazy var commonConstraints: [NSLayoutConstraint] = {
        return [scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                scrollView.frameLayoutGuide.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor),
                
                containerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
                containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        
                titleLabel.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: containerView.readableContentGuide.trailingAnchor),
                summaryLabel.trailingAnchor.constraint(equalTo: containerView.readableContentGuide.trailingAnchor)]
    }()
    
    private lazy var regularHeightConstraints: [NSLayoutConstraint] = {
        return [titleLabel.leadingAnchor.constraint(equalTo: containerView.readableContentGuide.leadingAnchor),
                
                sunImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                sunImage.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0),
        
                summaryLabel.leadingAnchor.constraint(equalTo: containerView.readableContentGuide.leadingAnchor),
                summaryLabel.topAnchor.constraint(equalToSystemSpacingBelow: sunImage.bottomAnchor, multiplier: 1.0),
                summaryLabel.bottomAnchor.constraint(equalTo: containerView.layoutMarginsGuide.bottomAnchor)]
    }()
    
    private lazy var optionalCompactHeightConstraint: NSLayoutConstraint = {
        let constraint = containerView.heightAnchor.constraint(equalToConstant: 0)
        constraint.priority = .defaultLow
        return constraint
    }()
    
    private lazy var compactHeightConstraints: [NSLayoutConstraint] = {
        return [titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: sunImage.trailingAnchor, multiplier: 1.0),
                
                sunImage.leadingAnchor.constraint(equalTo: containerView.readableContentGuide.leadingAnchor),
                sunImage.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor),
                containerView.bottomAnchor.constraint(greaterThanOrEqualTo: sunImage.bottomAnchor),
                
                summaryLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: sunImage.trailingAnchor, multiplier: 1.0),
                summaryLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0),
                containerView.bottomAnchor.constraint(greaterThanOrEqualTo: summaryLabel.bottomAnchor),
        
                optionalCompactHeightConstraint]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection != previousTraitCollection {
            activateConstraints(for: traitCollection)
        }
    }

    private func setupView() {
        navigationItem.title = "Challenge 14-2"
        view.backgroundColor = UIColor(red: 0.549, green: 0.835, blue: 0.984, alpha: 1.00)
        view.addSubview(scrollView)
        NSLayoutConstraint.activate(commonConstraints)
    }
    
    private func activateConstraints(for traitCollection: UITraitCollection) {
        switch traitCollection.verticalSizeClass {
        case .compact:
            NSLayoutConstraint.deactivate(regularHeightConstraints)
            NSLayoutConstraint.activate(compactHeightConstraints)
        default:
            NSLayoutConstraint.deactivate(compactHeightConstraints)
            NSLayoutConstraint.activate(regularHeightConstraints)
        }
    }
}

private extension UILabel {
    convenience init(text labelText: String, style labelStyle: UIFont.TextStyle, alignment labelAlign: NSTextAlignment) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        text = labelText
        textAlignment = labelAlign
        textColor = .black
        font = .preferredFont(forTextStyle: labelStyle)
        adjustsFontForContentSizeCategory = true
    }
}

