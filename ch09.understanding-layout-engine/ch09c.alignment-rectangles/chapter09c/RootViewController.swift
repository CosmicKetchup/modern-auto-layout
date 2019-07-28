//
//  RootViewController.swift
//  chapter09c
//
//  Created by Matt Brown on 7/27/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let mainImageView: UIImageView = {
        let originalImage = UIImage(named: "CrazyShadow")
        let imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 30)
        let insetImage = originalImage?.withAlignmentRectInsets(imageInsets)
        
        let iv = UIImageView(image: insetImage?.withRenderingMode(.alwaysOriginal))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(mainImageView)
        
        NSLayoutConstraint.activate([
            mainImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}

