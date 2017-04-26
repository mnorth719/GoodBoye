//
//  SpeechBubbleView.swift
//  GoodBoye
//
//  Created by Envoy on 4/7/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import UIKit

class SpeechBubbleView: UIView {

    @IBOutlet weak var speechLabel: UILabel!

    func show(text: String) {
        speechLabel.text = text
        
        if self.isHidden {
            self.alpha = 0
            self.isHidden = false
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, animations: {
                    self.alpha = 1.0
                }, completion: { success in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                       self.fadeOut()
                    })
                })
            }
        }
    }
    
    private func fadeOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0
        }, completion: { success in
            self.isHidden = true
        })
    }
    
    private func fadeIn() {
        self.alpha = 0
        self.isHidden = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1.0
        })
    }
}
