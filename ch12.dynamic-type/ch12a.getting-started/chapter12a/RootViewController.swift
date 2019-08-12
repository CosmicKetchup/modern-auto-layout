//
//  RootViewController.swift
//  chapter12a
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
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelStack)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        navigationItem.title = "Chapter 12a"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            labelStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            labelStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            labelStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            labelStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
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
