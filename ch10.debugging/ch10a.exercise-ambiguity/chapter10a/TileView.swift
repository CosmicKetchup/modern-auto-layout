//
//  TileView.swift
//  chapter10a
//
//  Created by Matt Brown on 7/29/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class TileView: UIView {
    
    private let redButton = UIButton(text: "Panic", bgColor: .red)
    private let blueButton = UIButton(text: "Don't Panic", bgColor: .blue)
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .green
        [redButton, blueButton].forEach({ addSubview($0) })
        
        NSLayoutConstraint.activate([
            redButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            blueButton.leadingAnchor.constraint(equalToSystemSpacingAfter: redButton.trailingAnchor, multiplier: 1.0),
            blueButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            // missing horizontal constraint causes layout ambiguity
//            redButton.widthAnchor.constraint(equalTo: blueButton.widthAnchor),
            
            redButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            redButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            blueButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            blueButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            ])
    }
}

private extension UIButton {
    convenience init(text buttonText: String, bgColor: UIColor) {
        self.init()
        backgroundColor = bgColor
        setTitle(buttonText, for: .normal)
        setTitleColor(.white, for: .normal)
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
