//
//  RootViewController.swift
//  chapter11b
//
//  Created by Matt Brown on 7/30/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let heartImage = UIImageView(imageName: "heart")
    private let starImage = UIImageView(imageName: "star")
    private let diamondImage = UIImageView(imageName: "diamond")
    
    private lazy var imageStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [heartImage, starImage, diamondImage])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = UIStackView.spacingUseSystem
        stack.alignment = .center
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageStack)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        navigationItem.title = "Chapter 11b"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: imageStack.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: imageStack.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: imageStack.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: imageStack.bottomAnchor),
            
            scrollView.widthAnchor.constraint(equalTo: imageStack.widthAnchor)
            ])
    }

}

private extension UIImageView {
    convenience init(imageName: String) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        image = UIImage(named: imageName)
        contentMode = .scaleAspectFit
    }
}

