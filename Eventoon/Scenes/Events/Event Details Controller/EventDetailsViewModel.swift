//
//  EventDetailsViewModel.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 17/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

final class EventDetailsViewModel {
    
    private let eventId: String?
    
    var event: Event?
    let dataSourceStream = PublishSubject<DataSource>()
    let purchaseDataStream = PublishSubject<Event>()
    let errorStream = PublishSubject<String>()
    
    // MARK: - Init
    init(eventId: String?) {
        self.eventId = eventId
    }
    
    // MARK: - View
    func didBecomeActive() {
        refresh()
    }
    
    func refresh() {
        EventsService.getEvent(with: eventId ?? "") { [weak self] (event, error) in
            guard error == nil else {
                self?.errorStream.onNext(error ?? ErrorConstants.genericFetchError)
                return
            }
            guard let event = event else {
                self?.dataSourceStream.onNext(DataSource())
                return
            }
            self?.event = event
            
            let imageRow = EventImageTableViewCell.newRow(imageUrl: event.image ?? "")
            let summaryRow = EventSummaryTableViewCell.newRow(event: event)
            let aboutRow = EventAboutTableViewCell.newRow(event: event)
            let locationRow = EventLocationTableViewCell.newRow(event: event)
            let buyRow = EventBuyButtonTableViewCell.newRow(event: event, buyTicketActions: self)
            
            let dataSource = DataSource(with: [imageRow, summaryRow, aboutRow, locationRow, buyRow])
            self?.dataSourceStream.onNext(dataSource)
        }
    }
}

// MARK: - Extension: BuyTicketCellProtocol
extension EventDetailsViewModel: BuyTicketCellProtocol {
    func goToTicketsDetails() {
        guard let event = event else { return }
        purchaseDataStream.onNext(event)
    }
}
