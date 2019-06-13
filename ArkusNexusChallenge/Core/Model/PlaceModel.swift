//
//  PlaceModel.swift
//  ArkusNexusChallenge
//
//  Created by guerrier on 6/12/19.
//  Copyright © 2019 guerra. All rights reserved.
//

import Foundation
import ObjectMapper

class PlaceModel: Mappable, CustomStringConvertible {
    
    var placeId:String      = ""
    var placeName:String    = ""
    var address:String      = ""
    var category:String     = ""
    var isOpenNow:String    = ""
    var latitude:Double     = 0.0
    var longitude:Double    = 0.0
    var thumbnail:String    = ""
    var rating:Double       = 0.0
    var isPetFriendly:Bool  = false
    var addressLine1:String = ""
    var addressLine2:String = ""
    var phoneNumber:String  = ""
    var site:String         = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        placeId         <- map["PlaceId"]
        placeName       <- map["PlaceName"]
        address         <- map["Address"]
        category        <- map["Category"]
        isOpenNow       <- map["IsOpenNow"]
        latitude        <- map["Latitude"]
        longitude       <- map["Longitude"]
        thumbnail       <- map["Thumbnail"]
        rating          <- map["Rating"]
        isPetFriendly   <- map["IsPetFriendly"]
        addressLine1    <- map["AddressLine1"]
        addressLine2    <- map["AddressLine2"]
        phoneNumber     <- map["PhoneNumber"]
        site            <- map["Site"]
    }
    
    var description: String {
        return  "PlaceModel: {PlaceID: \(placeId), PlaceName: \(placeName), Address: \(address), IsOpenNow: \(isOpenNow), Rating: \(rating), IsPetFriendly: \(isPetFriendly), PhoneNumer: \(phoneNumber)}"
    }
}
