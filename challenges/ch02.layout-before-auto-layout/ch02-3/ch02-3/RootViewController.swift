//
//  RootViewController.swift
//  ch02-3
//
//  Created by Matt Brown on 7/6/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private let rgbView: RGBView = {
        let view = RGBView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if rgbView.superview == nil {
            setupView()
        }
    }
}

extension RootViewController {
    fileprivate func setupView() {
        view.addSubview(rgbView)
        rgbView.frame = UIScreen.main.bounds
    }
}

