//
//  RootViewController.swift
//  ch12-2
//
//  Created by Matt Brown on 8/2/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private var scaleFactor: CGFloat = 2.0 {
        didSet {
            configureLabels()
        }
    }
    
    private lazy var headlineLabel: UILabel = {
        let label = UILabel(labelText: "Headline text style")
        return label
    }()
    
    private let subheadlineLabel: UILabel = {
        let label = UILabel(labelText: "Subheadline text style")
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headlineLabel, subheadlineLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    private lazy var stackContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelStack)
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        NSLayoutConstraint.activate([
            labelStack.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            labelStack.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            labelStack.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
            labelStack.bottomAnchor.constraint(equalTo: view.readableContentGuide.bottomAnchor)
            ])
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackContainer)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didChangePreferredFont(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
        setupView()
    }

    private func setupView() {
        configureLabels()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.frameLayoutGuide.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor),
            
            stackContainer.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackContainer.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackContainer.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackContainer.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            ])
    }
    
    private func configureLabels() {
        let headlineFont = UIFont.preferredFont(forTextStyle: .headline)
        headlineLabel.font = headlineFont.withSize(headlineFont.pointSize * scaleFactor)
        
        if let italicsDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .subheadline).withSymbolicTraits(.traitItalic) {
            let subheadlineFont = UIFont(descriptor: italicsDescriptor, size: 0)
            subheadlineLabel.font = subheadlineFont.withSize(subheadlineFont.pointSize * scaleFactor)
        }
    }
    
    @objc private func didChangePreferredFont(_ notification: Notification) {
        configureLabels()
    }
}

private extension UILabel {
    convenience init(labelText: String) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        textColor = .black
        text = labelText
    }
}

