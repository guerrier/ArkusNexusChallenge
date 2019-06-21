//
//  PlaceDetailViewController.swift
//  ArkusNexusChallenge
//
//  Created by guerrier on 6/21/19.
//  Copyright © 2019 guerra. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
import Contacts

class PlaceDetailViewController:UIViewController {
    
    @IBOutlet private var placeView: PlaceDetailView!
    var place:PlaceModel!
    var userLocation:CLLocation!
    var identifier:String = "segueWebsite"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        placeView.configure(place, userLocation: userLocation)
    }
    
    @IBAction func getDirections(_ sender: Any) {
        let destination:MKMapItem! = MKMapItem(placemark: MKPlacemark(
            coordinate: CLLocationCoordinate2DMake(place.latitude, place.longitude),
            addressDictionary: [CNPostalAddressStreetKey: place.address]))
        destination.name = place.placeName
        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        destination.openInMaps(launchOptions: launchOptions)
    }
    
    @IBAction func callPlace(_ sender: Any) {
        guard let number = URL(string: "tel://" + place.phoneNumber) else { return }
        
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    @IBAction func goWebsite(_ sender: Any) {
        self.performSegue(withIdentifier: identifier, sender: place.site)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifier {
            let webViewController:WebViewController = segue.destination as! WebViewController
            webViewController.url = sender as! String
        }
    }
    
}
