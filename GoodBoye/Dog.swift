//
//  Dog.swift
//  GoodBoye
//
//  Created by Envoy on 4/6/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import UIKit
import PromiseKit

struct DogImage {
    var image: UIImage
    var imageId: String
}

struct Dog {
    var breed: String
    var dogImage: DogImage?
    static let isLoveBug = true
}

extension Dog {
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
