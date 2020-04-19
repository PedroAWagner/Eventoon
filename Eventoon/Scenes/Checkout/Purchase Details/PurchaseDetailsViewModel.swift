//
//  PurchaseDetailsViewModel.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 18/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation
import RxSwift

final class PurchaseDetailsViewModel {
    
    private let event: Event?
    
    let dataSourceStream = PublishSubject<Event>()
    let cuponStream = PublishSubject<Bool>()
    
    // MARK: - Init
    init(event: Event?) {
        self.event = event
    }
    
    // MARK: - View
    func didBecomeActive() {
        refresh()
    }
    
    func refresh() {
        guard let event = event else {
            return
        }
        
        dataSourceStream.onNext(event)
    }
    
    func applyCupon(code: String) {
        guard let cupons = event?.cupons else {
            cuponStream.onNext(false)
            return
        }
        
        if cupons.contains(where: { $0.id.lowercased() == code.lowercased() }) {
            cuponStream.onNext(true)
        } else {
            cuponStream.onNext(false)
        }
    }
}
