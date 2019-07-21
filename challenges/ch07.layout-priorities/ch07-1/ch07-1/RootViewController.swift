//
//  RootViewController.swift
//  ch07-1
//
//  Created by Matt Brown on 7/20/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let authorLabel = UILabel(text: "William Shakespeare", backgroundColor: .yellow, textColor: .black)
    private let quoteLabel = UILabel(text: "To be, or not to be, that is the question", backgroundColor: .purple, textColor: .white)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if authorLabel.superview == nil && quoteLabel.superview == nil {
            setupView()
        }
    }
}

extension RootViewController {
    fileprivate func setupView() {
        [authorLabel, quoteLabel].forEach({ view.addSubview($0) })
        
        let quoteLabelWidthConstraint = quoteLabel.widthAnchor.constraint(equalTo: authorLabel.widthAnchor, multiplier: 2.0)
        quoteLabelWidthConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            authorLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            quoteLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: authorLabel.trailingAnchor, multiplier: 1.0),
            quoteLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            authorLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 160.0),
            quoteLabelWidthConstraint,
            
            authorLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            quoteLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            ])
    }
}

private extension UILabel {
    convenience init(text copy: String, backgroundColor color: UIColor, textColor: UIColor) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        text = copy
        backgroundColor = color
        self.textColor = textColor
        font = UIFont.systemFont(ofSize: 24)
    }
}

