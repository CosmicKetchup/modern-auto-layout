//
//  StopGoView.swift
//  chapter05d
//
//  Created by Matt Brown on 7/16/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class StopGoView: UIView {
    
    private enum ViewMetrics {
        static let rootPadding: CGFloat = 50.0
        static let rootSpacing: CGFloat = 25.0
    }
    
    private let redView = UIView.makeView(color: .red)
    private let greenView = UIView.makeView(color: .green)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension StopGoView {
    fileprivate func setupView() {
        [redView, greenView].forEach({ addSubview($0) })
        
        NSLayoutConstraint.activate([
            redView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewMetrics.rootPadding),
            trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: ViewMetrics.rootPadding),
            greenView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            greenView.widthAnchor.constraint(equalTo: redView.widthAnchor),
            
            redView.topAnchor.constraint(equalTo: topAnchor, constant: ViewMetrics.rootPadding),
            greenView.topAnchor.constraint(equalTo: redView.bottomAnchor, constant: ViewMetrics.rootSpacing),
            bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: ViewMetrics.rootPadding),
            redView.heightAnchor.constraint(equalTo: greenView.heightAnchor)
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
