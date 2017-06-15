//
//  GBActivityIndicator.swift
//  GoodBoye
//
//  Created by Envoy on 4/7/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import UIKit

class GBActivityIndicator: UIView {
    @IBOutlet weak var boneEmojiImageView: UIImageView!
    private var rotationTimer: Timer?
    
    func showLoadingIndicator() {
        self.alpha = 0
        self.isHidden = false
        
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 1
        }, completion: {success in
            self.rotationTimer?.invalidate()
            self.rotationTimer = nil
            self.boneEmojiImageView.rotate360Degrees()
            self.rotationTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.rotate), userInfo: nil, repeats: true)
        })
    }
    
    func hideLoadingIndicator() {
        self.rotationTimer?.invalidate()
        self.rotationTimer = nil
        
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0
        }, completion: {success in
            self.isHidden = true
        })
    }
    
    @objc private func rotate() {
        self.boneEmojiImageView.rotate360Degrees()
    }
}

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate = completionDelegate as? CAAnimationDelegate{
            rotateAnimation.delegate = delegate
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
}

