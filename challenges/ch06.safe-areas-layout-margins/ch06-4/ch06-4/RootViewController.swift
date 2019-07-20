//
//  RootViewController.swift
//  ch06-4
//
//  Created by Matt Brown on 7/17/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private enum ViewMetrics {
        static let backgroundColor: UIColor = .yellow
        static let margin: CGFloat = 50.0
        static let customMargin: CGFloat = 25.0
        static let customHeightPct: CGFloat = 0.25
    }
    
    private let customView: TileView = {
        let view = TileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ViewMetrics.backgroundColor
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if customView.superview == nil {
            setupView()
        }
    }
}

extension RootViewController {
    fileprivate func setupView() {
        
        if #available(iOS 11, *) {
            customView.directionalLayoutMargins = NSDirectionalEdgeInsets(
                top: ViewMetrics.customMargin,
                leading: ViewMetrics.customMargin,
                bottom: ViewMetrics.customMargin,
                trailing: ViewMetrics.customMargin)
        }
        else {
            customView.layoutMargins = UIEdgeInsets(
                top: ViewMetrics.customMargin,
                left: ViewMetrics.customMargin,
                bottom: ViewMetrics.customMargin,
                right: ViewMetrics.customMargin)
        }
        
        view.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: safeLeadingAnchor, constant: ViewMetrics.margin),
            customView.trailingAnchor.constraint(equalTo: safeTrailingAnchor, constant: -ViewMetrics.margin),
            customView.topAnchor.constraint(equalTo: safeTopAnchor, constant: ViewMetrics.margin),
            customView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: ViewMetrics.customHeightPct)
            ])
    }
}
