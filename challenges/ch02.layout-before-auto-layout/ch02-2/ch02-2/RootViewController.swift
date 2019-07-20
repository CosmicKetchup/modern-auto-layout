//
//  RootViewController.swift
//  ch02-2
//
//  Created by Matt Brown on 7/6/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private enum ViewMetrics {
        static let backgroundColor: UIColor = .yellow
        static let rootViewPadding: CGFloat = 50.0
        static let greenViewPadding: CGFloat = 25.0
    }
    
    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    private let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.autoresizingMask = [.flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin]
        return view
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ViewMetrics.backgroundColor
        // Do any additional setup after loading the view.
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if greenView.superview == nil {
            setupView()
        }
    }
}

extension RootViewController {
    fileprivate func setupView() {
        view.addSubview(greenView)
        let gVWidth = view.bounds.width - (ViewMetrics.rootViewPadding * 2)
        let gVHeight = view.bounds.height - (ViewMetrics.rootViewPadding * 2)
        greenView.frame = CGRect(x: ViewMetrics.rootViewPadding, y: ViewMetrics.rootViewPadding, width: gVWidth, height: gVHeight)
        
        greenView.addSubview(redView)
        let rVWidth = greenView.bounds.width - (ViewMetrics.greenViewPadding * 2)
        let rVHeight: CGFloat = 100.0
        redView.frame = CGRect(x: ViewMetrics.greenViewPadding, y: (greenView.bounds.height - rVHeight) / 2, width: rVWidth, height: rVHeight)
    }
}

