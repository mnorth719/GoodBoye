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
    case InvalidImage = 601
    case InvalidURL = 602
}

struct ImageService {
    
    enum Constants {
        static let apiKey = "31bf951f97db4768ae189f4e070a7f63"
        static let errorDomain = "com.mmn.ImageService"
    }
    
    static func getImage(withUrl: URL) -> Promise<UIImage> {
        return Promise { fulfill, reject in
            request(withUrl).validate().responseData { response in
                switch response.result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        fulfill(image)
                    } else {
                        let error = NSError(
                            domain: Constants.errorDomain,
                            code: ImageServiceErrorType.InvalidImage.rawValue,
                            userInfo: nil
                        )
                        reject(error as Error)
                    }
                case .failure(let error):
                    //standard error from AF
                    reject(error)
                }
            }
        }
    }
}
