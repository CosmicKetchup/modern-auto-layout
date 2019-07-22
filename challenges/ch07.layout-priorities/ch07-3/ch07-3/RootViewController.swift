//
//  RootViewController.swift
//  ch07-3
//
//  Created by Matt Brown on 7/20/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let greenView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(greenView)
        
        let leadingEdgeConstraint = greenView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        leadingEdgeConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            greenView.widthAnchor.constraint(equalTo: greenView.heightAnchor),
            greenView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor),
            greenView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor),
            greenView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greenView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            leadingEdgeConstraint
            ])
    }
}

