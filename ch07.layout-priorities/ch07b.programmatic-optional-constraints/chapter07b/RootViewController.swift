//
//  RootViewController.swift
//  chapter07b
//
//  Created by Matt Brown on 7/19/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let sunView = UIImageView(named: "sun", backgroundColor: .orange)
    private let snowView = UIImageView(named: "snow", backgroundColor: .blue)
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "This label should be below the tallest of the two images"
        label.font = UIFont.systemFont(ofSize: 32.0)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if sunView.superview == nil && snowView.superview == nil {
            setupView()
        }
    }
}

extension RootViewController {
    fileprivate func setupView() {
        [sunView, snowView, textLabel].forEach({ view.addSubview($0) })
        
        let optionalCaptionConstraint = textLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        optionalCaptionConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            sunView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            snowView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            textLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            sunView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            snowView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            textLabel.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: sunView.bottomAnchor, multiplier: 1.0),
            textLabel.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: snowView.bottomAnchor, multiplier: 1.0),
            
            optionalCaptionConstraint
            ])
    }
}

private extension UIImageView {
    convenience init(named name: String, backgroundColor: UIColor) {
        self.init(image: UIImage(named: name))
        self.backgroundColor = backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}

