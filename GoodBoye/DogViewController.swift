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

    override func viewDidLoad() {
        super.viewDidLoad()
        for vc in self.childViewControllers {
            if vc is FavoriteDogsViewController {
                //custom shiznit
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func findDogButtonPushed(_ sender: Any) {
        
        //Isnt this clean!
        //returns a type safe object of type Dog
        //once fetching is complete
        DogService.getRandomDog().then { dog in
            self.dogImageView.image = dog.image
        }.catch { error in
            //display error
        }
    }
}
