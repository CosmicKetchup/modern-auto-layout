//
//  BookHeaderView.swift
//  chapter13c
//
//  Created by Matt Brown on 2/8/20.
//  Copyright © 2020 Matt Brown. All rights reserved.
//

import UIKit

class BookHeaderView: UIView {
    
    fileprivate enum ViewMetrics {
        static let labelTextColor = UIColor.white
        static let directionalViewMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    }

    private let titleLabel = UILabel(style: .title1)
    private let authorLabel = UILabel(style: .title2)
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, authorLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = UIStackView.spacingUseSystem
        stack.directionalLayoutMargins = ViewMetrics.directionalViewMargins
        return stack
    }()
    
    init(book: Book) {
        super.init(frame: .zero)
        
        titleLabel.text = book.title
        authorLabel.text = book.author
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .blue
        
        [labelStack].forEach { addSubview($0) }
        NSLayoutConstraint.activate([
            labelStack.topAnchor.constraint(equalTo: readableContentGuide.topAnchor),
            labelStack.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
            labelStack.bottomAnchor.constraint(equalTo: readableContentGuide.bottomAnchor),
            labelStack.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor),
            ])
    }
}

private extension UILabel {
    convenience init(style: UIFont.TextStyle) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        font = .preferredFont(forTextStyle: style)
        adjustsFontForContentSizeCategory = true
        textColor = BookHeaderView.ViewMetrics.labelTextColor
    }
}
