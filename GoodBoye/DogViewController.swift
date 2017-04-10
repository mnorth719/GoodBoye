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
    
    @IBOutlet weak var activityIndicatorContainer: UIView!
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var findDogsButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speechBubble: SpeechBubbleView!
    private var barkTimer: Timer?
    private var activityIndicator: GBActivityIndicator?
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if activityIndicator == nil {
            let frame = CGRect(
                x: 0,
                y: 0,
                width: activityIndicatorContainer.frame.width,
                height: activityIndicatorContainer.frame.height
            )
            
            activityIndicator = Bundle.main.loadNibNamed("GBActivityIndicator", owner: activityIndicator, options: nil)?.first as? GBActivityIndicator
            activityIndicator?.frame = frame
            activityIndicatorContainer.addSubview(activityIndicator!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    deinit {
        barkTimer?.invalidate()
        barkTimer = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        barkTimer?.invalidate()
        barkTimer = nil
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
        showLoadingIndicator()
        
        
        DogService.getRandomDog().then { dog -> Void in
            self.statusLabel.isHidden = true
            self.dogImageView.image = dog.image
        }.catch { error in
            //display error
            self.dogImageView.image = nil
            self.statusLabel.text = "Oops! Had trouble finding a dog. Please try again."
            self.statusLabel.isHidden = false
        }.always {
            self.hideLoadingIndicator()
        }
    }
    
    @objc func barkDog() {
        let dogTransform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        DispatchQueue.main.async {
            self.speechBubble.show(text: "Woof!")
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.findDogsButton.transform = dogTransform
            }, completion: {success in
                UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                    self.findDogsButton.transform = CGAffineTransform.identity
                })
            })
        }
    }
    
    private func showLoadingIndicator() {
        if let activityIndicator = activityIndicator {
            activityIndicator.showLoadingIndicator()
        }
    }
    
    private func hideLoadingIndicator() {
        if let activityIndicator = activityIndicator {
            activityIndicator.hideLoadingIndicator()
        }
    }
    
    @IBAction func shareButtonPushed(_ sender: Any) {
        shareImage()
    }
    
    @IBAction func favoriteButtonPushed(_ sender: Any) {
        //TODO
    }
    
    private func shareImage() {
        // image to share
        guard let image = dogImageView.image else {
            return
        }
        
        // set up activity view controller
        let imageToShare = [image]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
}
