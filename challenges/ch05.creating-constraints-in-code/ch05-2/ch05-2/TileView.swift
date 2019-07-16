//
//  TileView.swift
//  ch05-2
//
//  Created by Matt Brown on 7/16/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class TileView: UIView {
    
    private enum ViewMetrics {
        static let backgroundColor: UIColor = .green
        static let padding: CGFloat = 25.0
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
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = ViewMetrics.backgroundColor
        
        [blueView, redView].forEach({ addSubview($0) })
        NSLayoutConstraint.activate([
            blueView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewMetrics.padding),
            redView.leadingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: ViewMetrics.padding),
            trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: ViewMetrics.padding),
            redView.widthAnchor.constraint(equalTo: blueView.widthAnchor),
            
            blueView.topAnchor.constraint(equalTo: topAnchor, constant: ViewMetrics.padding),
            redView.topAnchor.constraint(equalTo: topAnchor, constant: ViewMetrics.padding),
            bottomAnchor.constraint(equalTo: blueView.bottomAnchor, constant: ViewMetrics.padding),
            bottomAnchor.constraint(equalTo: redView.bottomAnchor, constant: ViewMetrics.padding),
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
