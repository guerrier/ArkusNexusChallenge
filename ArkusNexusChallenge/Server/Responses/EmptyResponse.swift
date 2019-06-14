//
//  EmptyResponse.swift
//  ArkusNexusChallenge
//
//  Created by guerrier on 6/13/19.
//  Copyright © 2019 guerra. All rights reserved.
//

import Foundation
import ObjectMapper

class EmptyResponse: Mappable {
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
    }
    
    init() {
    }
}
