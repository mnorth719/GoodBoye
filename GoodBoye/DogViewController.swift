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
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var barkTimer: Timer?
    private var activityIndicator: GBActivityIndicator?
    private var currentDog: GBDog?
    
    
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
        self.optionsView.isHidden = true
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
            self.dogImageView.image = dog.dogImage?.image
            self.currentDog = dog
            self.updateFavoriteButon()
            self.optionsView.isHidden = false
        }.catch { error in
            //display error
            self.dogImageView.image = nil
            self.statusLabel.text = "Oops! Had trouble finding a dog. Please try again."
            self.statusLabel.isHidden = false
            self.optionsView.isHidden = true
        }.always {
            self.hideLoadingIndicator()
            self.findDogsButton.isEnabled = true
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
    
    private func updateFavoriteButon() {
        guard let dog = currentDog else {
            return
        }
        
        FavoriteService.shared.isFavorite(dog: dog).then { isFavorite -> Void in
            DispatchQueue.main.async {
                if isFavorite {
                    self.favoriteButton.setImage(UIImage(named: "heartSelected"), for: .normal)
                } else {
                    self.favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
                }
            }
        }.catch { error in
            print("error in favorite service!! \(error.localizedDescription)")
            self.favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
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
    
    @IBAction func favoriteButtonPushed(_ sender: Any) {
        guard let dog = currentDog else {
            return
        }
        
        FavoriteService.shared.isFavorite(dog: dog).then { isFavorite -> Void in
            if isFavorite {
                FavoriteService.shared.remove(favorite: dog)
                self.favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
            } else {
                FavoriteService.shared.save(favorite: dog)
                self.favoriteButton.setImage(UIImage(named: "heartSelected"), for: .normal)
            }
        }.catch { error in
            print("error in favorite service!! \(error.localizedDescription)")
        }
    }
    
    @IBAction func shareButtonPushed(_ sender: Any) {
        shareImage()
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
