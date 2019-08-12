//
//  AdaptiveScrollView.swift
//  chapter11e
//
//  Created by Matt Brown on 7/30/19.
//  Copyright © 2019 Matt Brown. All rights reserved.
//

import UIKit

// Keith Harrison - https://useyourloaf.com/autolayout/
class AdaptiveScrollView: UIScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardDidShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo, let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardSize = frame.cgRectValue.size
        let newContentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        adjustContentInset(newContentInset)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        adjustContentInset(.zero)
    }
    
    private func adjustContentInset(_ newContentInset: UIEdgeInsets) {
        contentInset = newContentInset
        scrollIndicatorInsets = newContentInset
    }
}
