//
//  DogViewController.swift
//  GoodBoye
//
//  Created by Envoy on 4/6/17.
//  Copyright © 2017 mmn. All rights reserved.
//
//
import UIKit

class DogViewController: UIViewController {
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var findDogsButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speechBubble: SpeechBubbleView!
    private var barkTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.activityIndicator.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        barkTimer?.invalidate()
        barkTimer = nil
        
        barkTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(barkDog), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func findDogButtonPushed(_ sender: Any) {
        //Isnt this clean!
        //returns a type safe object of type Dog
        //once fetching is complete
        statusLabel.isHidden = true
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        DogService.getRandomDog().then { dog -> Void in
            self.statusLabel.isHidden = true
            self.dogImageView.image = dog.image
        }.catch { error in
            //display error
            self.statusLabel.text = "Oops! Had trouble finding a dog. Please try again."
            self.statusLabel.isHidden = false
        }.always {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    @objc func barkDog() {
        let dogTransform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        DispatchQueue.main.async {
            self.speechBubble.show(text: "Woof!")
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .beginFromCurrentState, animations: {
                self.findDogsButton.transform = dogTransform
            }, completion: {success in
                UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .beginFromCurrentState, animations: {
                    self.findDogsButton.transform = CGAffineTransform.identity
                })
            })
        }
    }
}
