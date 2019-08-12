//
//  RootViewController.swift
//  chapter11a
//
//  Created by Matt Brown on 7/28/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let customView: TileView = {
        let view = TileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customView)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        navigationItem.title = "Chapter 11a"
        view.backgroundColor = .yellow
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: customView.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: customView.bottomAnchor),
            
            scrollView.widthAnchor.constraint(equalTo: customView.widthAnchor)
            ])
    }
}

