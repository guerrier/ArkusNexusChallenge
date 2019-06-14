//
//  PlaceAPIRouter.swift
//  ArkusNexusChallenge
//
//  Created by guerrier on 6/13/19.
//  Copyright © 2019 guerra. All rights reserved.
//

import Alamofire
import ObjectMapper

enum PlaceAPIRouter: URLRequestConvertible {
    
    static let places = "v2/5bf3ce193100008900619966"
    
    case getPlaces
    
    public func asURLRequest() throws -> URLRequest {
        let result: (path: String, body: String?) = {
            switch  self {
            case .getPlaces:
                return (PlaceAPIRouter.places, nil)
            }
        }()
        
        let request: NSMutableURLRequest = APIUtils.createAPIRequest(result.path, body: result.body)
        
        return request as URLRequest
    }
}
