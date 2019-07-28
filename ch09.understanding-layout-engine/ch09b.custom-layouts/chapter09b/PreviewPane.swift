//
//  PreviewPane.swift
//  chapter09b
//
//  Created by Matt Brown on 7/27/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class PreviewPane: UIView {

    private var overflowViews = [UIView]()
    
    var stackSpacing: CGFloat = 16.0 {
        didSet {
            mainStack.spacing = stackSpacing
        }
    }
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = stackSpacing
        stack.alignment = .center
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(_ items: [UIView]) {
        overflowViews.removeAll()
        mainStack.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        items.forEach({ mainStack.addArrangedSubview($0) })
    }
    
    private func setupView() {
        addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        while mainStack.bounds.width > bounds.width,
            let overflowView = mainStack.arrangedSubviews.last {
                overflowView.removeFromSuperview()
                overflowViews.insert(overflowView, at: 0)
                updateConstraintsIfNeeded()
                super.layoutSubviews()
        }
        
        while let nextView = overflowViews.first,
            mainStack.bounds.width + stackSpacing + nextView.intrinsicContentSize.width <= bounds.width {
                mainStack.addArrangedSubview(nextView)
                overflowViews.remove(at: 0)
                updateConstraintsIfNeeded()
                super.layoutSubviews()
        }
    }
}
