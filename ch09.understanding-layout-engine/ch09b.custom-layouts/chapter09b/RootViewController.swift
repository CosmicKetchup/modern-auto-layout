//
//  RootViewController.swift
//  chapter09b
//
//  Created by Matt Brown on 7/27/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let itemCount: Int = 10
    
    private lazy var previewPane: PreviewPane = {
        let view = PreviewPane()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        refreshRandomViews()
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(previewPane)
        
        NSLayoutConstraint.activate([
            previewPane.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            previewPane.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            previewPane.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }

    private func refreshRandomViews() {
        var views = [UIView]()
        for count in 0 ..< itemCount {
            let view = UILabel()
            view.text = "\(count)"
            
            let viewFontSize = CGFloat(arc4random_uniform(64)) + 64.0
            view.font = UIFont.systemFont(ofSize: viewFontSize)
            view.backgroundColor = (count % 2 == 0) ? .red : .green
            views.append(view)
        }
        previewPane.show(views)
    }
}

