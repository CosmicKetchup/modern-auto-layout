//
//  RootViewController.swift
//  chapter06b
//
//  Created by Matt Brown on 7/16/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private enum ViewMetrics {
        static let backgroundColor: UIColor = .yellow
        static let margin: CGFloat = 50.0
    }
    
    private let customView: NestedView = {
        let view = NestedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = ViewMetrics.backgroundColor
        view.addSubview(customView)
        changeNestedMargins(inset: ViewMetrics.margin)
        
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            customView.topAnchor.constraint(equalTo: safeTopAnchor),
            customView.bottomAnchor.constraint(equalTo: safeBottomAnchor)
            ])
    }
    
    private func changeNestedMargins(inset: CGFloat) {
        if #available(iOS 11, *) {
            customView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        }
        else {
            customView.layoutMargins = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        }
    }
}

