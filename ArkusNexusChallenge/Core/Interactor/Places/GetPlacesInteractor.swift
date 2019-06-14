//
//  GetPlacesInteractor.swift
//  ArkusNexusChallenge
//
//  Created by guerrier on 6/13/19.
//  Copyright © 2019 guerra. All rights reserved.
//

import RxSwift

class GetPlacesInteractor {
    
    func execute() -> Observable<[PlaceModel]> {
        return PlaceServer().getplaces()
    }
}
