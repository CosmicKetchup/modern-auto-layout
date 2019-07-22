//
//  RootViewController.swift
//  chapter05c
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
            
        NSLayoutConstraint.activate([
            redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewMetrics.rootPadding),
            view.trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: ViewMetrics.rootPadding),
            greenView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            greenView.widthAnchor.constraint(equalTo: redView.widthAnchor),
            
            redView.topAnchor.constraint(equalTo: view.topAnchor, constant: ViewMetrics.rootPadding),
            greenView.topAnchor.constraint(equalTo: redView.bottomAnchor, constant: ViewMetrics.rootSpacing),
            view.bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: ViewMetrics.rootPadding),
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

