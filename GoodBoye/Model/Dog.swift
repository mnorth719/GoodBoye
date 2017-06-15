//
//  Dog.swift
//  GoodBoye
//
//  Created by Envoy on 4/6/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import UIKit
import PromiseKit

class DogImage: NSObject {
    var image: UIImage?
    var imageId: String?
    var imageURL: String
    
    init(image: UIImage?, imageId: String?, imageURL: String) {
        self.image = image
        self.imageId = imageId
        self.imageURL = imageURL
    }
}

class GBDog: NSObject {
    var breed: String?
    var dogImage: DogImage?
    var imageURL: String
    static let isLoveBug = true
    
    init(breed: String, dogImage: DogImage, imageURL: String) {
        self.imageURL = imageURL
        self.breed = breed
        self.dogImage = dogImage
    }
        
}

extension GBDog {
    static func DogBreeds() -> Promise<[String]> {
        return Promise { fulfill, reject in
            let path = Bundle.main.path(forResource: "breeds", ofType: "json")
            let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe) as Data
            
            if let jsonData = jsonData {
                if  let jsonObj = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, AnyObject> {
                    if let breeds = jsonObj?["dogs"] as? [String] {
                        return fulfill(breeds)
                    }
                }
            }
            
            let error = NSError(domain: "com.goodBoye.error", code: 700, userInfo: nil)
            reject(error)
        }
    }
    
    func addToFavorites() {
        FavoriteService.shared.save(favorite: self)
    }
    
    func removeFromFavorites() {
        FavoriteService.shared.remove(favorite: self)
    }
}
