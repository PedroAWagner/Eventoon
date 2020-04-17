//
//  EventsViewModel.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

final class EventsViewModel {
    
    var dataSourceDelegate: DataSourceProtocol?
    
    func didBecomeActive() {
        refresh()
    }
    
    func refresh() {
        EventsService.getEvents { [weak self] (events, error) in
            guard error == nil else {
                #warning("Properly handle this error message")
                return
            }
            guard let events = events else {
                self?.dataSourceDelegate?.reloadDataSource(DataSource())
                return
            }
            
            let items = events.compactMap { event -> Row in
                return EventsTableViewCell.newRow(event: event)
            }
            
            self?.dataSourceDelegate?.reloadDataSource(DataSource(with: items))
        }
    }
}
