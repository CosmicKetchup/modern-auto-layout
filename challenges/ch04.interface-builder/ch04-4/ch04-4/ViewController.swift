//
//  ViewController.swift
//  ch04-4
//
//  Created by Matt Brown on 7/7/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var verticalConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verticalConstraint.constant = -100
    }


    @IBAction func buttonTapped(_ sender: UIButton) {
        verticalConstraint.constant = 0
    }
}

