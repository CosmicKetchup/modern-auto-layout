//
//  RGBView.swift
//  ch02-3
//
//  Created by Matt Brown on 7/6/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

@IBDesignable
class RGBView: UIView {
    
    @IBInspectable private var spacing: CGFloat = 20.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    private lazy var redView = coloredView(.red)
    private lazy var greenView = coloredView(.green)
    private lazy var blueView = coloredView(.blue)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let subviewContainers: CGFloat = 3 // [redView, greenView, blueView]
        let containerWidth = bounds.width
        let containerHeight = (bounds.height - spacing * 2) / subviewContainers
        
        redView.frame = CGRect(x: 0, y: 0, width: containerWidth, height: containerHeight)
        greenView.frame = CGRect(x: 0, y: (containerHeight + spacing), width: containerWidth, height: containerHeight)
        blueView.frame = CGRect(x: 0, y: (containerHeight + spacing) * 2, width: containerWidth, height: containerHeight)
    }
}

extension RGBView {
    fileprivate func setupView() {
        backgroundColor = .white
        [redView, greenView, blueView].forEach({ addSubview($0) })
    }
    
    fileprivate func coloredView(_ color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        return view
    }
}
