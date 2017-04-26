//
//  DogService.swift
//  GoodBoye
//
//  Created by Envoy on 4/6/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import PromiseKit

struct DogService {
    fileprivate static func randomBreed(fromBreeds: [String]) -> String? {
        if fromBreeds.count > 0 {
            let randIndx = Int(arc4random_uniform(UInt32(fromBreeds.count)))
            return fromBreeds[randIndx]
        }
        
        return nil
    }
    
    static func getRandomDog() -> Promise<GBDog> {
        return Promise { fulfill, reject in
            var randomBreed: String = "Husky"
            GBDog.DogBreeds().then {(breeds: [String]) -> Promise<SearchResult> in
                if let breed = DogService.randomBreed(fromBreeds: breeds) {
                    randomBreed = breed
                }
                
                guard let searchURL = SearchService.searchURL(forDogBreed: randomBreed) else {
                    let error = NSError(
                        domain: ImageService.Constants.errorDomain,
                        code: ImageServiceErrorType.InvalidURL.rawValue,
                        userInfo: nil
                    )
                    throw error
                }
                
                return SearchService.search(withUrl: searchURL)
            }.then { searchResult -> Promise<DogImage> in
                if let value = ImageService.randomValue(from: searchResult), let url = URL(string: value.contentUrl) {
                    return ImageService.getImage(withUrl: url, imageId: value.imageId)
                } else {
                    let error = NSError(
                        domain: ImageService.Constants.errorDomain,
                        code: ImageServiceErrorType.InvalidURL.rawValue,
                        userInfo: nil
                    )
                    throw error
                }
            }.then { image in
                fulfill(GBDog(breed: randomBreed, dogImage: image, imageURL: image.imageURL))
            }.catch { error in
                reject(error)
            }
        }
    }
}

extension SearchService {
    static func searchURL(forDogBreed: String) -> URL? {
        let adjustedBreedForUrl = forDogBreed.replacingOccurrences(of: " ", with: "+")
        return URL(string:"https://api.cognitive.microsoft.com/bing/v5.0/images/search?q=dog+\(adjustedBreedForUrl)&count=20&offset=0&mkt=en-us&safeSearch=Moderate")
    }
}
