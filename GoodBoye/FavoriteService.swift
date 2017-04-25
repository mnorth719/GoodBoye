//
//  FavoriteService.swift
//  GoodBoye
//
//  Created by Envoy on 4/10/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import Foundation
import PromiseKit

class FavoriteService {
    static let shared = FavoriteService()
    private let dogQueue = DispatchQueue(label: "com.GoodBoye.DogQueue")
    private var favoriteDogs = Set<Dog>()
    
    func getFavoriteDogs() -> Promise<Dog> {
        return Promise { fulfill, reject in
            
        }
    }
    
    func save(favorite: Dog) {
        dogQueue.async {
            self.favoriteDogs.insert(favorite)
        }
    }
    
    func remove(favorite: Dog) {
        dogQueue.async {
            self.favoriteDogs.remove(favorite)
        }
    }
    
    func isFavorite(dog: Dog) -> Bool {
        return favoriteDogs.contains(dog)
    }
}

extension Dog: Hashable {
    var hashValue: Int {
        return dogImage?.imageId.hash ?? 0
    }
    
    func isEqual(lhs: Dog, rhs: Dog) -> Bool {
        return lhs == rhs
    }
}

func ==(lhs: Dog, rhs: Dog) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
