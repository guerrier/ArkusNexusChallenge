//
//  SuccessMessageResponse.swift
//  ArkusNexusChallenge
//
//  Created by guerrier on 6/13/19.
//  Copyright © 2019 guerra. All rights reserved.
//

import Foundation
import ObjectMapper

class SuccessMessageResponse: Mappable {
    
    var message: String = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        var currentMessage: String? = nil
        currentMessage <- map["message"]
        if let letMessage = currentMessage {
            message = letMessage
        } else {
            message <- map["success"]
        }
    }
    
    init() {
    }
}
