//
//  DogHeroViewController.swift
//  GoodBoye
//
//  Created by Matt  North on 4/25/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import UIKit

class DogHeroViewController: UIViewController {
    
    var dog: GBDog? {
        didSet {
            //check current rendered dog
            if let modeledDog = dogView?.dog {
                if modeledDog.dogImage?.imageId != dog?.dogImage?.imageId {
                    dogView?.dog = dog
                }
            }
        }
    }
    
    @IBOutlet weak var dogViewContainer: UIView!
    
    private var dogView: GBDogView?

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if dogView == nil {
            let frame = CGRect(
                x: 0,
                y: 0,
                width: dogViewContainer.frame.width,
                height: dogViewContainer.frame.height
            )
            
            dogView = Bundle.main.loadNibNamed("GBDogView", owner: dogView, options: nil)?.first as? GBDogView
            dogView?.frame = frame
            dogView?.delegate = self
            dogView?.dog = dog
            dogViewContainer.addSubview(dogView!)
            self.navigationItem.title = dog?.breed
        }
    }
}
