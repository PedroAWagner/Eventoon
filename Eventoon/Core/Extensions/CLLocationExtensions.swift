//
//  CLLocationExtensions.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 17/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import CoreLocation

extension CLLocation {
    static func getCurrentDistanceInMeters(from location: CLLocation) -> CLLocationDistance? {
        let locationManager = CLLocationManager()
        let currentCoordinates = locationManager.location
        
        return currentCoordinates?.distance(from: location)
    }
    
    static func getCurrentDistanceInKilometers(from location: CLLocation) -> CLLocationDistance? {
        let locationManager = CLLocationManager()
        let currentCoordinates = locationManager.location
        
        return ((currentCoordinates?.distance(from: location) ?? 1) / 1000).rounded(toPlaces: 2)
    }
    
    static func getCompleteAddressFromCoordinates(_ coordinates: CLLocation, completion: @escaping (String?) -> Void) {
        let address = CLGeocoder.init()
        address.reverseGeocodeLocation(coordinates) { places, error in
            guard error == nil else {
                completion(nil)
                return
            }
            if let place = places?.first {
                var addressString = ""
                addressString.append(place.name ?? "")
                addressString.space()
                addressString.append(place.thoroughfare ?? "")
                addressString.space()
                addressString.append(place.subThoroughfare ?? "")
                
                completion(addressString)
            }
        }
    }
}
