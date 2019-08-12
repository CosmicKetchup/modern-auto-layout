//
//  RootViewController.swift
//  chapter12b
//
//  Created by Matt Brown on 7/30/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let bookExcerpt = "My father's family name being Pirrip, and my Christian name Philip, my infant tongue could make of both names nothing longer or more explicit than Pip. So, I called myself Pip, and came to be called Pip."
    
    private let chapterLabel = UILabel(labelText: "Chapter 1", labelStyle: .headline)
    private lazy var excerptLabel = UILabel(labelText: bookExcerpt, labelStyle: .body)
    private let authorLabel = UILabel(labelText: "Great Expectations by Charles Dickens", labelStyle: .footnote)
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [chapterLabel, excerptLabel, authorLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelStack)
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = "Chapter 12b"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            labelStack.leadingAnchor.constraint(equalTo: containerView.readableContentGuide.leadingAnchor),
            labelStack.trailingAnchor.constraint(equalTo: containerView.readableContentGuide.trailingAnchor),
            labelStack.topAnchor.constraint(equalTo: containerView.readableContentGuide.topAnchor),
            labelStack.bottomAnchor.constraint(equalTo: containerView.readableContentGuide.bottomAnchor),
            
            scrollView.frameLayoutGuide.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor)
            ])
    }
}

private extension UILabel {
    convenience init(labelText: String, labelStyle: UIFont.TextStyle) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        text = labelText
        textColor = .black
        font = UIFont.preferredFont(forTextStyle: labelStyle)
        adjustsFontForContentSizeCategory = true
        numberOfLines = 0
    }
}

