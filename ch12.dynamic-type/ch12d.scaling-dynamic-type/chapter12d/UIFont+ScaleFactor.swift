//
//  UIFont+ScaleFactor.swift
//  chapter12d
//
//  Created by Matt Brown on 7/31/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

// Keith Harrison - https://useyourloaf.com/autolayout/
public extension UIFont {
    
    static func preferredFont(forTextStyle style: UIFont.TextStyle, scaleFactor: CGFloat) -> UIFont {
        let font = UIFont.preferredFont(forTextStyle: style)
        return font.withSize(font.pointSize * scaleFactor)
    }
}
