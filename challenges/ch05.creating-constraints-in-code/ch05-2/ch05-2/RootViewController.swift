//
//  RootViewController.swift
//  ch05-2
//
//  Created by Matt Brown on 7/16/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private enum ViewMetrics {
        static let backgroundColor: UIColor = .yellow
        static let padding: CGFloat = 50.0
        static let customHeightPct: CGFloat = 0.25
    }
    
    private let customView: TileView = {
        let view = TileView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = ViewMetrics.backgroundColor
        view.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewMetrics.padding),
            view.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: ViewMetrics.padding),
            customView.topAnchor.constraint(equalTo: view.topAnchor, constant: ViewMetrics.padding),
            customView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: ViewMetrics.customHeightPct)
            ])
    }
}

