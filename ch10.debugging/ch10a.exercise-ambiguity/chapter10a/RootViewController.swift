//
//  RootViewController.swift
//  chapter10a
//
//  Created by Matt Brown on 7/29/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let customView: TileView = {
        let view = TileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.exerciseAmbiguity(self.view)
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            customView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.4)
            ])
    }
}

