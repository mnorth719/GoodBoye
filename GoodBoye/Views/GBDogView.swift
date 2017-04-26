//
//  GBDogView.swift
//  GoodBoye
//
//  Created by Matt  North on 4/25/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import UIKit

protocol DogViewDelegate: class {
    func shouldShare(image: UIImage)
}

class GBDogView: UIView {
    enum Constants {
        static let favoriteImage = UIImage(named: "heartSelected")
        static let unfavoriteImage = UIImage(named: "favorite")
    }
    
    @IBOutlet fileprivate weak var dogImage: UIImageView!
    @IBOutlet fileprivate weak var optionsView: UIView!
    @IBOutlet fileprivate weak var favoriteButton: UIButton!
    
    ///Setting this will update the views corresponding
    ///subviews based on the data provided
    var dog: GBDog? {
        didSet {
            updateOutlets()
            
            if dog != nil {
                showOptions(animated: true)
            } else {
                hideOptions(animated: true)
            }
        }
    }
    
    weak var delegate: DogViewDelegate?
    
    func hideOptions(animated: Bool) {
        if optionsView.alpha == 0 {
            return
        }
        
        DispatchQueue.main.async {
            if animated {
                UIView.animate(withDuration: 0.3, animations: {[weak self] in
                    self?.optionsView.alpha = 0
                })
            } else {
                self.optionsView.alpha = 0
            }
        }
    }
    
    func showOptions(animated: Bool) {
        if optionsView.alpha == 1 {
            return
        }
        
        DispatchQueue.main.async {
            if animated {
                UIView.animate(withDuration: 0.3, animations: {[weak self] in
                    self?.optionsView.alpha = 1
                })
            } else {
                self.optionsView.alpha = 1
            }
        }
    }

    private func updateOutlets() {
        guard let dog = dog else {
            hideOptions(animated: true)
            return
        }
        
        DispatchQueue.main.async {
            if dog.dogImage?.image == nil {
                if let url = URL(string: dog.imageURL) {
                    self.dogImage.kf.setImage(with: url)
                }
            } else {
                self.dogImage.image = dog.dogImage?.image
            }
        }
    
        FavoriteService.shared.isFavorite(dog: dog).then { isFavorite in
            DispatchQueue.main.async {
                if isFavorite {
                    self.favoriteButton.setImage(Constants.favoriteImage, for: .normal)
                } else {
                    self.favoriteButton.setImage(Constants.unfavoriteImage, for: .normal)
                }
            }
        }.catch { error in
            //default in error state
            self.favoriteButton.setImage(Constants.unfavoriteImage, for: .normal)
        }
    }
    
    @IBAction func shareButtonPushed(_ sender: Any) {
        if let image = self.dogImage.image {
            self.delegate?.shouldShare(image: image)
        }
    }
    
    @IBAction func favoriteButtonPushed(_ sender: Any) {
        guard let dog = dog else {
            return
        }
        
        FavoriteService.shared.isFavorite(dog: dog).then { isFavorite -> Void in
            DispatchQueue.main.async {
                if isFavorite {
                    dog.removeFromFavorites()
                    self.favoriteButton.setImage(Constants.unfavoriteImage, for: .normal)
                } else {
                    dog.addToFavorites()
                    self.favoriteButton.setImage(Constants.favoriteImage, for: .normal)
                }
            }
        }.catch { error in
                print("error in favorite service!! \(error.localizedDescription)")
        }
    }
}
