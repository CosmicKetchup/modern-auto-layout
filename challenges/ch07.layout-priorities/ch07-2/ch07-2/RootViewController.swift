//
//  RootViewController.swift
//  ch07-2
//
//  Created by Matt Brown on 7/20/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private enum ViewMetrics {
        static let fontSize: CGFloat = 24.0
        static let shareButtonInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.systemFont(ofSize: ViewMetrics.fontSize)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.contentEdgeInsets = ViewMetrics.shareButtonInsets
        
        return button
    }()
    
    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .purple
        label.textColor = .white
        label.text = "To be, or not to be, that is the question"
        label.font = UIFont.systemFont(ofSize: ViewMetrics.fontSize)
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white
        [shareButton, quoteLabel].forEach({ view.addSubview($0) })
        
        NSLayoutConstraint.activate([
            shareButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            quoteLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: shareButton.trailingAnchor, multiplier: 1.0),
            quoteLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            shareButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            quoteLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            ])
    }
}

