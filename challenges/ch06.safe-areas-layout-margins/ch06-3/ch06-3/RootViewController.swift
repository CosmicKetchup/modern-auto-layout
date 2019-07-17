//
//  RootViewController.swift
//  ch06-3
//
//  Created by Matt Brown on 7/17/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private enum ViewMetrics {
        static let backgroundColor: UIColor = .yellow
        static let margin: CGFloat = 50.0
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
        if customView.superview == nil {
            setupView()
        }
    }
}

extension RootViewController {
    fileprivate func setupView() {
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: ViewMetrics.margin,
            leading: ViewMetrics.margin,
            bottom: ViewMetrics.margin,
            trailing: ViewMetrics.margin
        )
        
        view.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            customView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            customView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: ViewMetrics.customHeightPct)
            ])
    }
}

