//
//  EventsViewModel.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class EventsViewModel {
    
    let dataSourceStream = PublishSubject<DataSource>()
    let coordinatorActionsStream = PublishSubject<Event>()
    
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
                self?.dataSourceStream.onNext(DataSource())
                return
            }
            
            let items = events.compactMap { [weak self] event -> Row in
                return EventsTableViewCell.newRow(event: event, actionsStream: self?.coordinatorActionsStream)
            }
            
            self?.dataSourceStream.onNext(DataSource(with: items))
        }
    }
}
