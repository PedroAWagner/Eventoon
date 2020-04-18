//
//  EventLocationTableViewCell.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 18/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit
import MapKit

final class EventLocationTableViewCell: UITableViewCell {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    static func newRow(event: Event) -> Row {
        let row = Row(identifier: String(describing: EventLocationTableViewCell.self))
        
        row.setConfiguration { (cell, row, indexPath) in
            guard let cell = cell as? EventLocationTableViewCell else { return }
            
            cell.selectionStyle = .none
            cell.setLocations(from: event)
        }
        
        return row
    }
    
    private func setLocations(from event: Event) {
        let eventCoordinates = CLLocation(latitude: event.latitude, longitude: event.longitude)
        
        let coordinateRegion = MKCoordinateRegion(center: eventCoordinates.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        let annotation = MKPointAnnotation()
        annotation.coordinate = eventCoordinates.coordinate
//        annotation.title =
        
        map.addAnnotation(annotation)
        map.setRegion(coordinateRegion, animated: true)
        
        map.isUserInteractionEnabled = false
        
        CLLocation.getCompleteAddressFromCoordinates(eventCoordinates) { [weak self] address in
            self?.addressLabel.text = address
        }
    }
}
