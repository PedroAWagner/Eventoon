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

final class EventDetailsViewModel {
    
    private let eventId: String?
    
    let dataSourceStream = PublishSubject<DataSource>()
    
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
                #warning("Properly handle this error message")
                return
            }
            guard let event = event else {
                self?.dataSourceStream.onNext(DataSource())
                return
            }
            let imageRow = EventImageTableViewCell.newRow(imageUrl: event.image ?? "")
            let summaryRow = EventSummaryTableViewCell.newRow(event: event)
            let aboutRow = EventAboutTableViewCell.newRow(event: event)
            let locationRow = EventLocationTableViewCell.newRow(event: event)
            
            let dataSource = DataSource(with: [imageRow, summaryRow, aboutRow, locationRow])
            self?.dataSourceStream.onNext(dataSource)
        }
    }
}
