//
//  EventsTableViewCell.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation

final class EventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var attendanceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    static func newRow(event: Event, actionsStream: PublishSubject<Event>?) -> Row {
        let row = Row(identifier: String(describing: EventsTableViewCell.self))
        
        row.setConfiguration { (cell, row, indexPath) in
            guard let cell = cell as? EventsTableViewCell else { return }
            cell.titleLabel.text = event.title
            cell.attendanceLabel.text = String(format: "%@: %i", StringConstants.attendants, event.people?.count ?? 0)
            cell.priceLabel.text = String.currency(from: event.price)
            cell.eventImageView.downloadImage(url: event.image ?? "")
            
            cell.setLocations(from: event)
            
            cell.wrapperView.backgroundColor = .baseLightGray
            cell.wrapperView.cornerOn(.all, radius: 10)
        }
        
        row.setDidSelect { (_, _, _) in
            actionsStream?.onNext(event)
        }
        
        return row
    }
    
    private func setLocations(from event: Event) {
        let eventCoordinates = CLLocation(latitude: event.latitude, longitude: event.longitude)
        let distance = CLLocation.getCurrentDistanceInKilometers(from: eventCoordinates)
        
        distanceLabel.text = String.distanceInKilometers(from: distance)
        
        CLLocation.getCompleteAddressFromCoordinates(eventCoordinates) { [weak self] address in
            self?.addressLabel.text = address
        }
    }
}
