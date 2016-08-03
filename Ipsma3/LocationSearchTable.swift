//
//  LocationSearchTable.swift
//  Ipsma3
//
//  Created by Buka Cakrawala on 8/3/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//

import UIKit
import MapKit


class LocationSearchTable: UITableViewController {
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView? = nil
    
    
    
}



extension LocationSearchTable: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        func updateSearchResultsForSearchController(searchController: UISearchController) {
            guard let mapView = mapView,
                let searchBarText = searchController.searchBar.text else { return }
            let request = MKLocalSearchRequest()
            request.naturalLanguageQuery = searchBarText
            request.region = mapView.region
            let search = MKLocalSearch(request: request)
            search.startWithCompletionHandler { response, _ in
                guard let response = response else {
                    return
                }
                self.matchingItems = response.mapItems
                self.tableView.reloadData()
            }
        }

    }
}


