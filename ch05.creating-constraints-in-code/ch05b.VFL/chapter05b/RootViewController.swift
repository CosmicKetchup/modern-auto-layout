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
        static let rootSpacing: CGFloat = 25.0
    }
    
    private let redView = UIView.makeView(color: .red)
    private let greenView = UIView.makeView(color: .green)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = ViewMetrics.backgroundColor
        [redView, greenView].forEach({ view.addSubview($0) })
        
        let vflViews = [
            "redView": redView,
            "greenView": greenView
        ]
        
        let vflMetrics = [
            "padding": ViewMetrics.rootPadding,
            "spacing": ViewMetrics.rootSpacing
        ]
        
        let hRedConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(padding)-[redView]-(padding)-|",
            options: [],
            metrics: vflMetrics,
            views: vflViews)
        
        let hGreenConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(padding)-[greenView]-(padding)-|",
            options: [],
            metrics: vflMetrics,
            views: vflViews)
        
        let vConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(padding)-[redView(==greenView)]-(spacing)-[greenView]-(padding)-|",
            options: [],
            metrics: vflMetrics,
            views: vflViews)
        
        NSLayoutConstraint.activate(hRedConstraints + hGreenConstraint + vConstraints)

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

