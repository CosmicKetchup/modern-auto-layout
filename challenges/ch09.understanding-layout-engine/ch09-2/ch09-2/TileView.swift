//
//  TileView.swift
//  ch09-2
//
//  Created by Matt Brown on 7/28/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class TileView: UIView {

    private enum ViewMetrics {
        static let buttonSpacing: CGFloat = 16.0
    }
    
    private let greenButton = UIButton(text: "Don't Panic Don't Panic", bgColor: .green)
    private let redButton = UIButton(text: "Panic Panic", bgColor: .red)
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [greenButton, redButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = ViewMetrics.buttonSpacing
        stack.distribution = .fillEqually
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
        backgroundColor = .blue
        addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            buttonStack.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let minButtonWidth = max(greenButton.intrinsicContentSize.width, redButton.intrinsicContentSize.width)
        let minHorizontalWidth = minButtonWidth * 2 + ViewMetrics.buttonSpacing
        buttonStack.axis = minHorizontalWidth <= layoutMarginsGuide.layoutFrame.width ? .horizontal : .vertical
    }
}

private extension UIButton {
    convenience init(text buttonText: String, bgColor: UIColor) {
        self.init()
        backgroundColor = bgColor
        setTitle(buttonText, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 24.0)
        
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
