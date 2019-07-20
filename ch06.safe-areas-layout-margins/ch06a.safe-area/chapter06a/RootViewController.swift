//
//  RootViewController.swift
//  chapter06a
//
//  Created by Matt Brown on 7/16/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private enum ViewMetrics {
        static let backgroundColor: UIColor = .yellow
        static let padding: CGFloat = 50.0
        static let spacing: CGFloat = 25.0
    }
    
    private let redView = UIView.makeView(color: .red)
    private let greenView = UIView.makeView(color: .green)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ViewMetrics.backgroundColor
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if redView.superview == nil && greenView.superview == nil {
            setupView()
        }
    }
}

extension RootViewController {
    fileprivate func setupView() {
        [redView, greenView].forEach({ view.addSubview($0) })
        
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            redView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: ViewMetrics.padding),
            view.trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: ViewMetrics.padding),
            greenView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: ViewMetrics.padding),
            view.trailingAnchor.constraint(equalTo: greenView.trailingAnchor, constant: ViewMetrics.padding),
            
            redView.topAnchor.constraint(equalTo: guide.topAnchor, constant: ViewMetrics.padding),
            greenView.topAnchor.constraint(equalTo: redView.bottomAnchor, constant: ViewMetrics.spacing),
            view.bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: ViewMetrics.padding),
            greenView.heightAnchor.constraint(equalTo: redView.heightAnchor)
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
