//
//  PurchaseDetailsViewModel.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 18/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation
import RxSwift

typealias ApplyCuponResult = (Bool, Int?)

final class PurchaseDetailsViewModel {
    
    private let event: Event?
    
    let dataSourceStream = PublishSubject<Event>()
    let cuponStream = PublishSubject<ApplyCuponResult>()
    let paymentProcessingStream = PublishSubject<Bool>()
    
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
            
            cuponStream.onNext(ApplyCuponResult(false, nil))
            return
        }
        
        guard let cupon = cupons.first(where: { $0.id.lowercased() == code.lowercased()}) else {
            cuponStream.onNext(ApplyCuponResult(false, nil))
            return
        }
        
        cuponStream.onNext(ApplyCuponResult(true, cupon.discount))
    }
    
    func finilizePurchase() {
        /*Haveriam claro metodos de pagamento e handlers aqui,
            mas não julguei necessário implementar isso para este teste*/
        //After payment is confirmed
        guard let user = User.currentUser,
            let event = event else { return }
        CheckoutService.checkout(event: event, user: user) { [weak self] (success) in
            self?.paymentProcessingStream.onNext(success)
        }
    }
}
