//
//  TileView.swift
//  chapter02a
//
//  Created by Matt Brown on 7/6/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

@IBDesignable
final class TileView: UIView {
    
    @IBInspectable var padding: CGFloat = 25.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    private lazy var blueView = coloredView(.blue)
    private lazy var redView = coloredView(.red)
    
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
        
        // size of this custom subview container
        let containerWidth = bounds.width
        let containerHeight = bounds.height
        
        // calculate width and height of each item, including padding
        let subviewItems: CGFloat = 2 // [blueView, redView]
        let subviewWidth = (containerWidth - (subviewItems + 1) * padding) / subviewItems
        let subviewHeight = containerHeight - (padding * 2)
        
        // set the frame of all subviews
        blueView.frame = CGRect(x: padding, y: padding, width: subviewWidth, height: subviewHeight)
        redView.frame = CGRect(x: (subviewWidth + (padding * 2)), y: padding, width: subviewWidth, height: subviewHeight)
    }
}

extension TileView {
    fileprivate func setupView() {
        backgroundColor = .green
        [blueView, redView].forEach({ addSubview($0) })
    }
    
    fileprivate func coloredView(_ color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        return view
    }
}
