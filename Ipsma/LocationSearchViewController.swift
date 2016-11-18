//
//  LocationSearchViewController.swift
//  Ipsma
//
//  Created by Buka Cakrawala on 11/16/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationSearchViewController: UIViewController {
    
    var resultSearchController: UISearchController? = nil
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //Triggers the location permission dialog.
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        let locationSearchTable = storyboard?.instantiateViewController(withIdentifier: "LocationSearchTableTableViewController") as! LocationSearchTableTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        //Create a property of searchBar
        let searchBar = resultSearchController?.searchBar
        searchBar?.sizeToFit()
        searchBar?.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        //This defines wether to hide the navigation bar and search bar, after the search results are showed
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        //dimsBackgroundDuringPresentation gives a little translucent touch when the seach bar is clicked.
        resultSearchController?.dimsBackgroundDuringPresentation = true
        //definesPresentationContext limits the frame, so that it doesn't overlaps the whole view.
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        
    }
}

extension LocationSearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    //This function calls back when the information of the location comes back.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: true)
        }
    }
    //to check if there is an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
