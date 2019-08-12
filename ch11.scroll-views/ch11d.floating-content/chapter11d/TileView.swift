//
//  TileView.swift
//  chapter11d
//
//  Created by Matt Brown on 7/30/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class TileView: UIView {
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Get Ready!"
        label.font = UIFont.systemFont(ofSize: 56.0)
        label.textAlignment = .center
        return label
    }()
    
    private let midImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "skater")?.withRenderingMode(.alwaysOriginal))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let botButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32.0)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return button
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topLabel, midImage, botButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        preservesSuperviewLayoutMargins = true
        backgroundColor = .clear
        addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            mainStack.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            ])
    }
}
