//
//  RootViewController.swift
//  ch11-1
//
//  Created by Matt Brown on 7/30/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Get Ready!"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 56)
        label.textAlignment = .center
        return label
    }()
    
    private let midImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "skater"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let botButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return button
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topLabel, midImage, botButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = UIStackView.spacingUseSystem
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0)
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStack)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        navigationItem.title = "Activity"
        view.backgroundColor = .yellow
        view.addSubview(scrollView)
        
        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide
        NSLayoutConstraint.activate([
            frameGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameGuide.topAnchor.constraint(equalTo: view.topAnchor),
            frameGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentGuide.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            contentGuide.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor),
            contentGuide.topAnchor.constraint(equalTo: mainStack.topAnchor),
            contentGuide.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor),
            
            frameGuide.widthAnchor.constraint(equalTo: contentGuide.widthAnchor)
            ])
    }
}

