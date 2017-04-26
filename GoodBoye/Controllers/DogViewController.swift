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
    
    @IBOutlet fileprivate weak var dogViewContainer: UIView!
    @IBOutlet fileprivate weak var activityIndicatorContainer: UIView!
    @IBOutlet fileprivate weak var findDogsButton: UIButton!
    @IBOutlet fileprivate weak var statusLabel: UILabel!
    @IBOutlet fileprivate weak var speechBubble: SpeechBubbleView!
    
    private var barkTimer: Timer?
    private var activityIndicator: GBActivityIndicator?
    private var dogView: GBDogView?
    
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
            dogViewContainer.addSubview(dogView!)
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
        FavoriteService.shared.getFavoriteDogs().then { dogs -> Void in
            print("favorite dogs: \(dogs.count)")
        }.catch { error in
            print("error in favorite service!! \(error.localizedDescription)")
        }
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
        findDogsButton.isEnabled = false
        
        DogService.getRandomDog().then { dog -> Void in
            self.statusLabel.isHidden = true
            print("dog id: \(dog.dogImage?.imageId ?? "")")
            self.dogView?.dog = dog
        }.catch { error in
            //display error
            self.dogView?.dog = nil
            self.statusLabel.text = "Oops! Had trouble finding a dog. Please try again."
            self.statusLabel.isHidden = false
        }.always {
            self.hideLoadingIndicator()
            self.findDogsButton.isEnabled = true
        }
    }
    
    private func showLoadingIndicator() {
        if let activityIndicator = activityIndicator {
            activityIndicatorContainer.isHidden = false
            activityIndicator.showLoadingIndicator()
        }
    }
    
    private func hideLoadingIndicator() {
        if let activityIndicator = activityIndicator {
            activityIndicator.hideLoadingIndicator()
            activityIndicatorContainer.isHidden = true
        }
    }
}

extension UIViewController: DogViewDelegate {
    func shouldShare(image: UIImage) {
        // set up activity view controller
        let imageToShare = [image]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
}
