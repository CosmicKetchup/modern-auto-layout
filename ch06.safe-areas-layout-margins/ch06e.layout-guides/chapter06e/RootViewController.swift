//
//  RootViewController.swift
//  chapter06e
//
//  Created by Matt Brown on 7/16/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private enum ViewMetrics {
        static let backgroundColor: UIColor = .white
        static let buttonTextColor: UIColor = .white
        static let buttonInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(ViewMetrics.buttonTextColor, for: .normal)
        button.contentEdgeInsets = ViewMetrics.buttonInsets
        return button
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.setTitle("OK", for: .normal)
        button.setTitleColor(ViewMetrics.buttonTextColor, for: .normal)
        button.contentEdgeInsets = ViewMetrics.buttonInsets
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = ViewMetrics.backgroundColor
        [cancelButton, okButton].forEach({ view.addSubview($0) })
        
        let leadingGuide = UILayoutGuide()
        let middleGuide = UILayoutGuide()
        let trailingGuide = UILayoutGuide()
        [leadingGuide, middleGuide, trailingGuide].forEach({ view.addLayoutGuide($0) })
        
        NSLayoutConstraint.activate([
            leadingGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: leadingGuide.trailingAnchor),
            middleGuide.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor),
            okButton.leadingAnchor.constraint(equalTo: middleGuide.trailingAnchor),
            trailingGuide.leadingAnchor.constraint(equalTo: okButton.trailingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingGuide.trailingAnchor),
            
            leadingGuide.widthAnchor.constraint(equalTo: middleGuide.widthAnchor),
            middleGuide.widthAnchor.constraint(equalTo: trailingGuide.widthAnchor),
            cancelButton.widthAnchor.constraint(equalTo: okButton.widthAnchor),
            
            cancelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            okButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}
