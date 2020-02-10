//
//  RootViewController.swift
//  chapter14g
//
//  Created by Matt Brown on 2/10/20.
//  Copyright © 2020 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private enum ViewMetrics {
        static let narrowThreshold: CGFloat = 500.0
    }
    
    private var isInitialSetupDone = false
    
    private let deleteButton = UIButton(text: "Delete All", bgColor: .red)
    private let completeButton = UIButton(text: "Mark Complete", bgColor: .green)
    private let leadingGuide = UILayoutGuide(), middleGuide = UILayoutGuide(), trailingGuide = UILayoutGuide()
    
    private lazy var commonConstraints: [NSLayoutConstraint] = {
        return [
            deleteButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            deleteButton.widthAnchor.constraint(equalTo: completeButton.widthAnchor)
        ]
    }()
    
    private lazy var wideConstraints: [NSLayoutConstraint] = {
        return [
            completeButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            leadingGuide.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: leadingGuide.trailingAnchor),
            middleGuide.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor),
            completeButton.leadingAnchor.constraint(equalTo: middleGuide.trailingAnchor),
            trailingGuide.leadingAnchor.constraint(equalTo: completeButton.trailingAnchor),
            view.layoutMarginsGuide.trailingAnchor.constraint(equalTo: trailingGuide.trailingAnchor),
            
            leadingGuide.widthAnchor.constraint(equalTo: middleGuide.widthAnchor),
            middleGuide.widthAnchor.constraint(equalTo: trailingGuide.widthAnchor),
        ]
    }()
    
    private lazy var narrowConstraints: [NSLayoutConstraint] = {
        return [
            completeButton.topAnchor.constraint(equalToSystemSpacingBelow: deleteButton.bottomAnchor, multiplier: 2.0),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            completeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .lightGray
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        [deleteButton, completeButton].forEach { view.addSubview($0) }
        [leadingGuide, middleGuide, trailingGuide].forEach { view.addLayoutGuide($0) }
        
        NSLayoutConstraint.activate(commonConstraints)
    }
    
    override func viewWillLayoutSubviews() {
        if !isInitialSetupDone {
            activateConstraints(for: view.bounds.width)
            isInitialSetupDone = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if size != view.bounds.size {
            activateConstraints(for: size.width)
        }
    }
    
    private func activateConstraints(for width: CGFloat) {
        if width > ViewMetrics.narrowThreshold {
            NSLayoutConstraint.deactivate(narrowConstraints)
            NSLayoutConstraint.activate(wideConstraints)
        }
        else {
            NSLayoutConstraint.deactivate(wideConstraints)
            NSLayoutConstraint.activate(narrowConstraints)
        }
    }
}

private extension UIButton {
    convenience init(text: String, bgColor: UIColor) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = bgColor
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        setTitle(text, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.textAlignment = .center
    }
}

