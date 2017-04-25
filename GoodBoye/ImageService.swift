//
//  ImageService.swift
//  GoodBoye
//
//  Created by Envoy on 4/6/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit

typealias fetchImageCompletion = (_ image: UIImage) -> ()

enum ImageServiceErrorType: Int {
    case InvalidResponse = 600
    case InvalidImage = 601
    case InvalidURL = 602
}

struct ImageService {
    
    enum Constants {
        static let apiKey = "ca8759cdb36f4c1991a16a3167a17ef8"
        static let errorDomain = "com.mmn.WebServices"
    }
    
    static func getImage(withUrl: URL, imageId: String) -> Promise<DogImage> {
        return Promise { fulfill, reject in
            request(withUrl).validate().responseData { response in
                switch response.result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        let dogImage = DogImage(image: image, imageId: imageId)
                        fulfill(dogImage)
                    }else {
                        let error = NSError(
                            domain: Constants.errorDomain,
                            code: ImageServiceErrorType.InvalidImage.rawValue,
                            userInfo: nil
                        )
                        reject(error)
                    }
                case .failure(let error):
                    //standard error from AF
                    reject(error)
                }
            }
        }
    }
    
    static func randomValue(from: SearchResult) -> Value? {
        let randIndx = Int(arc4random_uniform(UInt32(from.value.count)))
        return from.value[randIndx]
    }
}
