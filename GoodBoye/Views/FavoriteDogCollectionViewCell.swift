//
//  FavoriteDogCollectionViewCell.swift
//  GoodBoye
//
//  Created by Matt  North on 4/25/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import UIKit
import Kingfisher

class FavoriteDogCollectionViewCell: UICollectionViewCell {
    
    enum Constants {
        static let reuseId = "FavoriteDogCollectionViewCell"
        static let nibName = "FavoriteDogCollectionViewCell"
    }
    
    @IBOutlet fileprivate weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.kf.cancelDownloadTask()
    }
    
    func setup(with dog: GBDog) {
        guard let url = URL(string: dog.imageURL) else {
            imageView.image = nil
            return
        }
        
        imageView.kf.setImage(with: url)
    }
}
