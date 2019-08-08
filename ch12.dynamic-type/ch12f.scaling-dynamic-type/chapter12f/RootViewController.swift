//
//  RootViewController.swift
//  chapter12f
//
//  Created by Matt Brown on 7/31/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    var scaleFactor: CGFloat = 1.0 {
        didSet {
            configureLabels()
        }
    }
    
    private lazy var headlineLabel = UILabel(labelText: "Headline", textStyle: .headline, scale: scaleFactor)
    private lazy var bodyLabel = UILabel(labelText: "Body", textStyle: .body, scale: scaleFactor)
    private lazy var footnoteLabel = UILabel(labelText: "Footnote", textStyle: .footnote, scale: scaleFactor)

    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headlineLabel, bodyLabel, footnoteLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didChangePreferredFont(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(labelStack)
        
        NSLayoutConstraint.activate([
            labelStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            labelStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            labelStack.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
//            labelStack.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    private func configureLabels() {
        headlineLabel.font = UIFont.preferredFont(forTextStyle: .headline, scaleFactor: scaleFactor)
        bodyLabel.font = UIFont.preferredFont(forTextStyle: .body, scaleFactor: scaleFactor)
        footnoteLabel.font = UIFont.preferredFont(forTextStyle: .footnote, scaleFactor: scaleFactor)
    }
    
    @objc private func didChangePreferredFont(_ notification: Notification) {
        configureLabels()
    }
}

private extension UILabel {
    convenience init(labelText: String, textStyle: UIFont.TextStyle, scale: CGFloat) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        text = labelText
        font = UIFont.preferredFont(forTextStyle: textStyle, scaleFactor: scale)
//        adjustsFontForContentSizeCategory = true
        numberOfLines = 0
    }
}

