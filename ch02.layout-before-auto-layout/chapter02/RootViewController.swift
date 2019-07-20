//
//  RootViewController.swift
//  chapter02
//
//  Created by Matt Brown on 7/6/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    
    private enum ViewMetrics {
        static let padding: CGFloat = 50.0
        static let itemHeight: CGFloat = 150.0
        static let backgroundColor: UIColor = .yellow
    }
    
    private let greenView: TileView = {
        let view = TileView()
        view.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        return view
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ViewMetrics.backgroundColor
        
        // setupView() - view isn't added to hierarchy yet, so this is an unreliable spot to calculate layout metrics
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if greenView.superview == nil {
            setupView()
        }
    }
}

extension RootViewController {
    fileprivate func setupView() {
        view.addSubview(greenView)
        
        let itemWidth = view.bounds.width - (ViewMetrics.padding * 2)
        greenView.frame = CGRect(x: ViewMetrics.padding, y: ViewMetrics.padding, width: itemWidth, height: ViewMetrics.itemHeight)
        
        // percent-based corner radius
        greenView.layer.cornerRadius = greenView.bounds.width / 20
    }
}

