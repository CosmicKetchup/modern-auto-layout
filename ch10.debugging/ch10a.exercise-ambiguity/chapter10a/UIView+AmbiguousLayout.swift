//
//  UIView+AmbiguousLayout.swift
//  chapter10a
//
//  Created by Matt Brown on 7/29/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

// Florian Kugler - https://www.objc.io/issues/3-views/advanced-auto-layout-toolbox/
extension UIView {
    class func exerciseAmbiguity(_ view: UIView) {
        #if DEBUG
        if view.hasAmbiguousLayout {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                view.exerciseAmbiguityInLayout()
            }
        }
        else {
            view.subviews.forEach({ UIView.exerciseAmbiguity($0) })
        }
        #endif
    }
}
