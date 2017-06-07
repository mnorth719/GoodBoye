//
//  FavoriteService.swift
//  GoodBoye
//
//  Created by Envoy on 4/10/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import Foundation
import PromiseKit
import CoreData


class FavoriteService {
    static let shared = FavoriteService()
    private let dogQueue = DispatchQueue(label: "com.GoodBoye.DogQueue")
    private lazy var managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
    func getFavoriteDogs() -> Promise<[GBDog]> {
        return Promise { fulfill, reject in
            dogQueue.async {
                let fetchRequest = NSFetchRequest<Dog>(entityName: "Dog")
                do {
                    let dogs = try self.managedObjectContext.fetch(fetchRequest)
                    var returnArray = [GBDog]()
                    for dog in dogs {
                        if let breed = dog.breed, let url = dog.imageURL, let id = dog.id {
                            let dogImage = DogImage(image: nil, imageId: id, imageURL: url)
                            let gbDog = GBDog(breed: breed, dogImage: dogImage, imageURL: url)
                            returnArray.append(gbDog)
                        } else {
                            print("malformed dog data!!!")
                        }
                    }
                    
                    fulfill(returnArray)
                } catch {
                   reject(error)
                }
            }
        }
    }
    
    func save(favorite: GBDog) {
        dogQueue.async {
            let dog = Dog(context: self.managedObjectContext)
            dog.breed = favorite.breed
            dog.imageURL = favorite.imageURL
            dog.id = favorite.dogImage?.imageId
            self.managedObjectContext.insert(dog)
            try? self.managedObjectContext.save()
        }
    }
    
    func remove(favorite: GBDog) {
        dogQueue.async {
            guard let dogId = favorite.dogImage?.imageId else {
                return
            }
            
            let fetchRequest = NSFetchRequest<Dog>(entityName: "Dog")
            fetchRequest.predicate = NSPredicate(format: "id == %@", dogId)
            if let dogs = try? self.managedObjectContext.fetch(fetchRequest), let dog = dogs.first {
                self.managedObjectContext.delete(dog)
                try? self.managedObjectContext.save()
            }
        }
    }
    
    func isFavorite(dog: GBDog) -> Promise<Bool> {
        return Promise { fulfill, reject in
            dogQueue.async {
                guard let dogId = dog.dogImage?.imageId else {
                    let error = NSError(
                        domain: AppConstants.appErrorDomain,
                        code: GBCoreDataErrorType.InvalidRequest.rawValue,
                        userInfo: nil
                    )
                    
                    reject(error)
                    return
                }
                
                do {
                    let fetchRequest = NSFetchRequest<Dog>(entityName: "Dog")
                    fetchRequest.predicate = NSPredicate(format: "id == %@", dogId)
                    let dogs = try self.managedObjectContext.fetch(fetchRequest)
                    fulfill(dogs.count > 0)
                } catch {
                    reject(error)
                }
            }
        }
    }
}

extension GBDog: Hashable {
    var hashValue: Int {
        return dogImage?.imageId?.hash ?? 0
    }
    
    func isEqual(lhs: GBDog, rhs: GBDog) -> Bool {
        return lhs == rhs
    }
}

func ==(lhs: GBDog, rhs: GBDog) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
