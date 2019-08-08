//
//  RootViewController.swift
//  ch12-1
//
//  Created by Matt Brown on 7/31/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let bookLabel = UILabel(labelText: "Great Expectations", textStyle: .title1)
    private let authorLabel = UILabel(labelText: "Charles Dickens", textStyle: .headline)
    
    private let excerptView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        view.isEditable = false
        view.textColor = .black
        view.font = .preferredFont(forTextStyle: .body)
        view.adjustsFontForContentSizeCategory = true
        view.textContainer.lineFragmentPadding = 0
        
        view.text = """
        My father's name being Pirrip, and my Christian name Philip, my infant tongue could make of both names nothing longer or more explicit than Pip. So, I called myself Pip, and came to be called Pip.
        """
        
        return view
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [bookLabel, authorLabel, excerptView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStack)
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
        navigationItem.title = "Challenge 12-1"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: containerView.topAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            scrollView.frameLayoutGuide.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor),
            
            mainStack.leadingAnchor.constraint(equalTo: containerView.readableContentGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: containerView.readableContentGuide.trailingAnchor),
            mainStack.topAnchor.constraint(equalTo: containerView.readableContentGuide.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: containerView.readableContentGuide.bottomAnchor)
            ])
    }
}

private extension UILabel {
    convenience init(labelText: String, textStyle: UIFont.TextStyle) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        text = labelText
        textColor = .black
        font = .preferredFont(forTextStyle: textStyle)
        adjustsFontForContentSizeCategory = true
    }
}

