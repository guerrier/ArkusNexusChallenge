//
//  PlaceDetailView.swift
//  ArkusNexusChallenge
//
//  Created by guerrier on 6/21/19.
//  Copyright © 2019 guerra. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import HCSStarRatingView
import Contacts

class PlaceDetailView:UIView, MKMapViewDelegate {
    
    @IBOutlet weak var mapViewPlace: MKMapView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: HCSStarRatingView!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var iconPetFriendly: UIImageView!
    @IBOutlet weak var addressLine1: UILabel!
    @IBOutlet weak var addressLine2: UILabel!
    @IBOutlet weak var eta: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var website: UILabel!
    
    var place:PlaceModel!
    var pointAnnotation:CustomPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    let pinIdentifier:String = "iconPin"
    
    public func configure(_ model: PlaceModel, userLocation: CLLocation){
        self.place = model
        mapViewPlace.delegate = self
        mapViewPlace.mapType = .standard
        mapViewPlace.showsUserLocation = false
        
        let location = CLLocationCoordinate2D(latitude: place!.latitude, longitude: place!.longitude)
        
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
        mapViewPlace.setRegion(region, animated: true)
        
        pointAnnotation = CustomPointAnnotation()
        pointAnnotation.pinCustomImageName = "iconPin"
        pointAnnotation.coordinate = location
        
        pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: pinIdentifier)
        mapViewPlace.addAnnotation(pinAnnotationView.annotation!)
        
        name.text = place.placeName
        rating.value = CGFloat(place.rating)
        
        if place.distance >= 1000.0 {
            let formatter:MeasurementFormatter = MeasurementFormatter()
            let distanceinKM:Measurement = Measurement(value: place.distance, unit: UnitLength.meters)
            
            formatter.unitStyle = MeasurementFormatter.UnitStyle.short
            formatter.locale = Locale(identifier: "es_MX")
            distance.text = formatter.string(from: distanceinKM)
        } else {
            distance.text = place.distance.description + " m"
        }
        
        iconPetFriendly.isHidden = !place.isPetFriendly
        addressLine1.text = place.addressLine1
        addressLine2.text = place.addressLine2
        //TODO: ETA
        
        let source:MKMapItem = MKMapItem( placemark: MKPlacemark(
            coordinate: userLocation.coordinate,
            addressDictionary: nil))
        let destination:MKMapItem! = MKMapItem(placemark: MKPlacemark(
            coordinate: CLLocationCoordinate2DMake(place.latitude, place.longitude),
            addressDictionary: [CNPostalAddressStreetKey: place.address]))
        destination.name = place.placeName
        
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = source
        directionsRequest.destination = destination
        
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate { (response, error) -> Void in
            
            let distance = response!.routes.first?.expectedTravelTime // meters
            self.eta.text = String(format: "%.2f min drive", distance! / 60)
        }
        
        phoneNumber.text = place.phoneNumber
        website.text = place.site
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: pinIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        let customPointAnnotation = annotation as! CustomPointAnnotation
        annotationView?.image = UIImage(named: customPointAnnotation.pinCustomImageName)
        
        return annotationView
    }
}


class CustomPointAnnotation: MKPointAnnotation {
    var pinCustomImageName:String!
}
