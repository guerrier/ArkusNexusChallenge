//
//  PlacesTableViewController.swift
//  ArkusNexusChallenge
//
//  Created by guerrier on 6/21/19.
//  Copyright © 2019 guerra. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class PlacesTableViewController: UITableViewController{
    
    var presenter:PlacesViewPresenter?
    let locationManager:CLLocationManager = CLLocationManager()
    var userLocation:CLLocation?
    let placeSegueIdentifier:String = "showPlaceSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logoFigo")
        imageView.image = image
        navigationItem.titleView = imageView
        
        
        presenter = PlacesViewPresenter(view: self)
        presenter?.start()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.places?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PlaceViewCell = tableView.dequeueReusableCell(withIdentifier: "placeViewCell", for: indexPath) as! PlaceViewCell
        
        cell.configure((presenter?.places?[indexPath.row])!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: placeSegueIdentifier, sender: presenter?.places![indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == placeSegueIdentifier {
            let placeDetailController:PlaceDetailViewController = segue.destination as! PlaceDetailViewController
            let place:PlaceModel = sender as! PlaceModel
            placeDetailController.place = place
            placeDetailController.userLocation = userLocation
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
    
}

extension PlacesTableViewController : CLLocationManagerDelegate {
    
    
    func getUserLocation(){
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate:CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        userLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        presenter?.sortPlacesByDistance(userLocation: userLocation!)
        locationManager.stopUpdatingLocation()
    }
}
