//
//  APIUtils.swift
//  ArkusNexusChallenge
//
//  Created by guerrier on 6/12/19.
//  Copyright © 2019 guerra. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class APIUtils {
    
    static func createAPIRequest(_ path: String, body: String?, httpMethod: String = "POST") -> NSMutableURLRequest{
        var apiURL: URL = URL(string: Constants.ArkusNexusAPI.BaseApiURL)!
        apiURL = apiURL.appendingPathComponent(path)
        return createRequest(apiURL: apiURL, body: body, httpMethod: httpMethod)
    }
    
    static func createRequest(apiURL: URL, body: String?, httpMethod: String) -> NSMutableURLRequest{
        
        let mutableURLRequest = NSMutableURLRequest(url: apiURL)
        
        mutableURLRequest.httpMethod = httpMethod
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let dataBody = body {
            mutableURLRequest.httpBody = dataBody.data(using: String.Encoding.utf8)
        }
        else {
            mutableURLRequest.httpBody = "{}".data(using: String.Encoding.utf8)
        }
        
        return mutableURLRequest
    }
}
