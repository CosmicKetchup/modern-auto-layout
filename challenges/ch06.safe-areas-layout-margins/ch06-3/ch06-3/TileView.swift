//
//  TileView.swift
//  ch06-3
//
//  Created by Matt Brown on 7/17/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class TileView: UIView {
    
    private enum ViewMetrics {
        static let backgroundColor: UIColor = .green
        static let margin: CGFloat = 25.0
    }
    
    private let blueView = UIView.makeView(color: .blue)
    private let redView = UIView.makeView(color: .red)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TileView {
    fileprivate func setupView() {
        backgroundColor = ViewMetrics.backgroundColor
        
        directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: ViewMetrics.margin,
            leading: ViewMetrics.margin,
            bottom: ViewMetrics.margin,
            trailing: ViewMetrics.margin
        )
        
        [blueView, redView].forEach({ addSubview($0) })
        
        NSLayoutConstraint.activate([
            blueView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            redView.leadingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: ViewMetrics.margin),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            redView.widthAnchor.constraint(equalTo: blueView.widthAnchor),
            
            blueView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            layoutMarginsGuide.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
            redView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            layoutMarginsGuide.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            ])
    }
}

private extension UIView {
    static func makeView(color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
}
