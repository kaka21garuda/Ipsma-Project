//
//  LocationSearchTableTableViewController.swift
//  Ipsma
//
//  Created by Buka Cakrawala on 11/16/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTableTableViewController: UITableViewController, UISearchResultsUpdating {
    //This is the property where it will store the matching search results.
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView? = nil
    
    func updateSearchResults(for searchController: UISearchController) {
        //Setup the API call
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        //Change the string from the searchBarText into a requestable string.
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        
        //MKLocalSearch performs the actual search.
        let search = MKLocalSearch(request: request)
        //startCompletionHandler executes the query search, and return MKLocalSearchResponse which contains an array of mapitems that will be stored inside the matchingItems array property.
        search.start { (response, error) in
            guard let response = response else {
                return
            }
            //Append the mapItems into matchingItems array.
            self.matchingItems = response.mapItems
            //Reload the data inside the tableview / refresh it.
            self.tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let selectedItem = matchingItems[indexPath.row].placemark
        cell?.textLabel?.text = selectedItem.name
        cell?.detailTextLabel?.text = "insert description here."
        return cell!
    }
    
}

