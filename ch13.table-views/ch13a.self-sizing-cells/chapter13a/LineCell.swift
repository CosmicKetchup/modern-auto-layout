//
//  LineCell.swift
//  chapter13a
//
//  Created by Matt Brown on 2/7/20.
//  Copyright © 2020 Matt Brown. All rights reserved.
//

import UIKit

final class LineCell: UITableViewCell, ReusableIdentifier {
    
    private let lineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    private let textView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .body)
        view.adjustsFontForContentSizeCategory = true
        view.isEditable = false
        view.isScrollEnabled = false
        return view
    }()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [lineLabel, textView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [contentStack].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            contentStack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    func configure(line: Int, text: String?) {
        lineLabel.text = line.description
        textView.text = text
    }
}
