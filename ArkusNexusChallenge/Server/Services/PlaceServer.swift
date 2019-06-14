//
//  PlaceServer.swift
//  ArkusNexusChallenge
//
//  Created by guerrier on 6/13/19.
//  Copyright © 2019 guerra. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire
import ObjectMapper

class PlaceServer {
    func getplaces() -> Observable<PlaceModel> {
        return ArkusNexusServer<PlaceModel>().request(PlaceAPIRouter.getPlaces)
    }
}
