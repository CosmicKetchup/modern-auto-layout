//
//  MessageCell.swift
//  ch13-1
//
//  Created by Matt Brown on 2/9/20.
//  Copyright © 2020 Matt Brown. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell, ReusableIdentifier {

    private enum ViewMetrics {
        static let imageSize = CGSize(width: 60, height: 60)
        static let nameLabelFont = UIFont.preferredFont(forTextStyle: .headline)
        static let messageLabelFont = UIFont.preferredFont(forTextStyle: .body)
    }
    
    private let profileImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "profile"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.tintColor = .blue
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.font = ViewMetrics.nameLabelFont
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.font = ViewMetrics.messageLabelFont
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, messageLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    init(message: Message) {
        super.init(style: .default, reuseIdentifier: MessageCell.reuseIdentifier)
        nameLabel.text = message.author
        messageLabel.text = message.content
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [profileImage, labelStack].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            profileImage.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: ViewMetrics.imageSize.width),
            profileImage.heightAnchor.constraint(equalToConstant: ViewMetrics.imageSize.height),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: profileImage.bottomAnchor),
            
            labelStack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            labelStack.leadingAnchor.constraint(equalToSystemSpacingAfter: profileImage.trailingAnchor, multiplier: 1.0),
            labelStack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            labelStack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            ])
    }
}
