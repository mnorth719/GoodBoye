//
//  SearchService.swift
//  GoodBoye
//
//  Created by Envoy on 4/7/17.
//  Copyright © 2017 mmn. All rights reserved.
//

import PromiseKit
import Alamofire

struct SearchService {
    enum Constants {
        static let apiToken = "ca8759cdb36f4c1991a16a3167a17ef8"
        static let errorDomain = "com.mmn.WebServices"
        static let apiDictKey = "Ocp-Apim-Subscription-Key"
    }
    
    static func search(withUrl: URL) -> Promise<SearchResult> {
        return Promise { fulfill, reject in
            let tokenDict = [Constants.apiDictKey : Constants.apiToken]
            request(withUrl, parameters: nil, headers: tokenDict).validate().responseJSON { response in
                switch response.result {
                case .success(let json):
                    if let json = json as? [String : Any] {
                        let resultObj = SearchResult(fromDictionary: json)
                        fulfill(resultObj)
                    }else {
                        let error = NSError(
                            domain: Constants.errorDomain,
                            code: ImageServiceErrorType.InvalidResponse.rawValue,
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
}
