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


protocol HandleMapSearch {
    func dropPinZoomIn(placeMark: MKPlacemark)
}

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    
    //PROPERTY FOR UISearchController
    var resultSearchController: UISearchController? = nil
    
    //1.. CREATE LOCATION MANAGER WHICH WILL DETECT THE USER'S CURRENT LOCATION
    let locationManager = CLLocationManager()
    
    //SHOWING ALERT WHEN USER DENIED THE AUTHORIZATION
    let showAlert = UIAlertController()
    
    //PIN
    var selectedPin: MKPlacemark? = nil
    
    
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
        
         
        
        let locationSearchTable = storyboard!.instantiateViewControllerWithIdentifier("LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        //THIS WILL CONFIGURE THE SEARCH BAR AND EMBEDS IT WITHIN THE NAVIGATION BAR
        let searchBar = resultSearchController?.searchBar
        searchBar?.sizeToFit()
        searchBar?.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
    }


    /**************************************************************************/
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
/****************************************************************************/
    
    
    // MKMapViewDelegate's METHOD IN ORDER TO DRAW THE CIRCLE
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.redColor()
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        print("viewForannotation")
        if annotation is MKUserLocation {
            //return nil
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            //println("Pinview was nil")
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
        }
        
        
        let button = UIButton(type: .ContactAdd)
        
        
        
        pinView?.rightCalloutAccessoryView = button
        
        
        return pinView
        
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegueWithIdentifier("invitationSegue", sender: self)
 
    }
    
}

extension ViewController: HandleMapSearch {
    func dropPinZoomIn(placeMark: MKPlacemark) {
        //TAKE THE PIN
        selectedPin = placeMark
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = placeMark.coordinate
        annotation.title = placeMark.name
        
        if let city = placeMark.locality,
            let state = placeMark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placeMark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}
/************************************************************************/