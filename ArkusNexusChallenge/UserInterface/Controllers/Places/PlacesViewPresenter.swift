//
//  PlacesViewPresenter.swift
//  ArkusNexusChallenge
//
//  Created by guerrier on 6/21/19.
//  Copyright © 2019 guerra. All rights reserved.
//

import Foundation
import RxSwift
import CoreLocation

class PlacesViewPresenter{
    weak var view:PlacesTableViewController?
    
    var places:[PlaceModel]?
    
    private var disposeBag:DisposeBag = DisposeBag()
    
    init(view: PlacesTableViewController){
        self.view = view
    }
    
    func start() {
        places = [PlaceModel]()
        self.loadPlaces()
    }
    
    func loadPlaces(){
        GetPlacesInteractor().execute().subscribe(
            onNext: { [weak self] places in
                print("Places : \(places)")
                self?.places = places
                self?.view?.getUserLocation()
        }).disposed(by: disposeBag)
    }
    
    func sortPlacesByDistance(userLocation: CLLocation) {
        var placesWithDistance: [PlaceModel] = (places?.map({
            let placeLocation:CLLocation = CLLocation(latitude: $0.latitude, longitude: $0.longitude)
            $0.distance = userLocation.distance(from: placeLocation)
            return $0
             }))!
        placesWithDistance.sort(by: {$0.distance < $1.distance})
        places = placesWithDistance
        self.view?.tableView.reloadData()
    }
}

