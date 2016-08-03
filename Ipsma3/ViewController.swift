//
//  ViewController.swift
//  Ipsma3
//
//  Created by Buka Cakrawala on 8/2/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    //1.. CREATE LOCATION MANAGER WHICH WILL DETECT THE USER'S CURRENT LOCATION
    let locationManager = CLLocationManager()
    
    //SHOWING ALERT WHEN USER DENIED THE AUTHORIZATION
    let showAlert = UIAlertController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2..   SETUP LOCATION MANAGER
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        //3.. SETUP MAPVIEW
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .Follow
        
        //.. SETUP TEST DATA
        setupData()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        //1.. WHEN STATUS IS NOT DETERMINED
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        
        //2.. WHEN AUTHORIZATION WERE DENIED, SHOW ALERT!!!
        else if CLLocationManager.authorizationStatus() == .Denied {
            showAlert.message = "Location services were previously denied. Please enable location services for this app in Settings."
        }
        
        //EVERYTHING IS SET AND READY TO UPDATE USER'S CURRENT LOCATION!!!
        else if CLLocationManager.authorizationStatus() == .AuthorizedAlways {
            locationManager.startUpdatingLocation()
        }
    
    }
    
    func setupData() {
        //MONITORING REGION
        
    }


}


















