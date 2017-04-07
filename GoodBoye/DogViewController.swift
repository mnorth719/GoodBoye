//
//  DogViewController.swift
//  GoodBoye
//
//  Created by Envoy on 4/6/17.
//  Copyright © 2017 mmn. All rights reserved.
//
// All credit goes to Jeffrey Ha, and therefore all money goes to him
// Signed: Matt North
// 
// PS: Fuck you jeff 
//
import UIKit

class DogViewController: UIViewController {
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var findDogsButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.activityIndicator.isHidden = true
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
}
