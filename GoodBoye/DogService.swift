//
//  DogService.swift
//  GoodBoye
//
//  Created by Envoy on 4/6/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import PromiseKit

struct DogService {
    static func getRandomDog() -> Promise<Dog> {
        return Promise { fulfill, reject in
            
            //TODO... this is not random obviously
            let randomBreed = "husky"
            guard let url = ImageService.url(forDogBreed: randomBreed) else {
                let error = NSError(
                    domain: ImageService.Constants.errorDomain,
                    code: ImageServiceErrorType.InvalidURL.rawValue,
                    userInfo: nil
                )
                reject(error)
                return
            }
            
            ImageService.getImage(withUrl: url).then { image in
                fulfill(Dog(breed: randomBreed, image: image))
            }.catch { error in
                reject(error)
            }
        }
    }
}

extension ImageService {
    static func url(forDogBreed: String) -> URL? {
        return URL(string:"https://api.cognitive.microsoft.com/bing/v5.0/images/search?q=\(forDogBreed)&count=20&offset=0&mkt=en-us&safeSearch=Moderate")
    }
}
