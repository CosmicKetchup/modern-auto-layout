//
//  RootViewController.swift
//  chapter11e
//
//  Created by Matt Brown on 7/30/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let infoButton: UIButton = {
        let button = UIButton(type: .infoDark)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let customView: TileView = {
        let view = TileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: AdaptiveScrollView = {
        let view = AdaptiveScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        [customView, infoButton].forEach({ view.addSubview($0) })
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = "Chapter 11e"
        view.backgroundColor = .yellow
        view.addSubview(scrollView)
        
        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            frameGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameGuide.topAnchor.constraint(equalTo: view.topAnchor),
            frameGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentGuide.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            contentGuide.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            contentGuide.topAnchor.constraint(equalTo: customView.topAnchor),
            contentGuide.bottomAnchor.constraint(equalTo: customView.bottomAnchor),
            
            frameGuide.widthAnchor.constraint(equalTo: contentGuide.widthAnchor),
            
            infoButton.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            infoButton.topAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.topAnchor)
            ])
    }
}

