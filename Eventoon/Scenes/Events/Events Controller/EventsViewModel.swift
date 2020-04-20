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
    let showEventsDetailStream = PublishSubject<Event>()
    let createUserActionStream = PublishSubject<Void>()
    let errorStream = PublishSubject<String>()
    
    func didBecomeActive() {
        refresh()
        checkUserInfos()
    }
    
    func refresh() {
        EventsService.getEvents { [weak self] (events, error) in
            guard error == nil else {
                self?.errorStream.onNext(error ?? ErrorConstants.genericFetchError)
                return
            }
            guard let events = events else {
                self?.dataSourceStream.onNext(DataSource())
                return
            }
            
            let items = events.compactMap { [weak self] event -> Row in
                return EventsTableViewCell.newRow(event: event, actionsStream: self?.showEventsDetailStream)
            }
            
            self?.dataSourceStream.onNext(DataSource(with: items))
        }
    }
    
    private func checkUserInfos() {
        guard let userData = UserDefaults.standard.value(forKey: "User") as? Data else {
            createUserActionStream.onNext(Void())
            return
        }
        
        do {
            let user = try JSONDecoder().decode(User.self, from: userData)
            User.currentUser = user
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
