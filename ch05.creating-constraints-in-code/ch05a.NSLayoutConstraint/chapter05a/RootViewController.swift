//
//  RootViewController.swift
//  chapter05a
//
//  Created by Matt Brown on 7/16/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private enum ViewMetrics {
        static let backgroundColor: UIColor = .yellow
        static let rootPadding: CGFloat = 50.0
    }
    
    private let redView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ViewMetrics.backgroundColor
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if redView.superview == nil {
            setupView()
        }
    }
}

extension RootViewController {
    fileprivate func setupView() {
        view.addSubview(redView)
        
        // This is demonstrably the most painful way to add constraints between elements within the view hierarchy.
        NSLayoutConstraint.activate([
            // redView.leading == view.leading + ViewMetrics.rootPadding
            NSLayoutConstraint(
                item: redView,
                attribute: .leading,
                relatedBy: .equal,
                toItem: view,
                attribute: .leading,
                multiplier: 1.0,
                constant: ViewMetrics.rootPadding),
            
            // view.trailing == redView.trailing + ViewMetrics.rootPadding
            NSLayoutConstraint(
                item: view as Any,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: redView,
                attribute: .trailing,
                multiplier: 1.0, constant: ViewMetrics.rootPadding),
            
            // redView.top == view.top + ViewMetrics.rootPadding
            NSLayoutConstraint(
                item: redView,
                attribute: .top,
                relatedBy: .equal,
                toItem: view,
                attribute: .top,
                multiplier: 1.0,
                constant: ViewMetrics.rootPadding),
            
            // view.bottom == redView.bottom + ViewMetrics.rootPadding
            NSLayoutConstraint(
                item: view as Any,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: redView,
                attribute: .bottom,
                multiplier: 1.0,
                constant: ViewMetrics.rootPadding)
            ])
    }
}

