//
//  RootViewController.swift
//  ch05-1
//
//  Created by Matt Brown on 7/16/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private enum ViewMetrics {
        static let backgroundColor: UIColor = .yellow
        static let rootPadding: CGFloat = 50.0
        static let greenPadding: CGFloat = 25.0
        static let redHeightPct: CGFloat = 0.2
    }
    
    private let greenView = UIView.makeView(color: .green)
    private let redView = UIView.makeView(color: .red)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ViewMetrics.backgroundColor
    }


    override func viewWillLayoutSubviews() {
        if greenView.superview == nil {
            setupView()
        }
    }
}

extension RootViewController {
    fileprivate func setupView() {
        view.addSubview(greenView)
        NSLayoutConstraint.activate([
            greenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewMetrics.rootPadding),
            view.trailingAnchor.constraint(equalTo: greenView.trailingAnchor, constant: ViewMetrics.rootPadding),
            greenView.topAnchor.constraint(equalTo: view.topAnchor, constant: ViewMetrics.rootPadding),
            view.bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: ViewMetrics.rootPadding)
            ])
        
        greenView.addSubview(redView)
        
        NSLayoutConstraint.activate([
            redView.leadingAnchor.constraint(equalTo: greenView.leadingAnchor, constant: ViewMetrics.greenPadding),
            greenView.trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: ViewMetrics.greenPadding),
            redView.centerYAnchor.constraint(equalTo: greenView.centerYAnchor),
            redView.heightAnchor.constraint(equalTo: greenView.heightAnchor, multiplier: ViewMetrics.redHeightPct)
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

