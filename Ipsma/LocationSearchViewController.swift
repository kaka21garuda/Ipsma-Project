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

class LocationSearchViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
    }
}
