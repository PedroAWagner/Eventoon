//
//  StringExtensions.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 17/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

extension String {
    static func currency(from price: Decimal?) -> String? {
        guard let price = price else {
            return nil
        }
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        return formatter.string(from: price as NSNumber)
    }
    
    static func setDiscount(_ discount: Int, to price: String) -> String? {
        let currencySymbol = Locale.current.currencySymbol ?? ""
        let price = price.replacingOccurrences(of: currencySymbol, with: "").trimmingCharacters(in: .whitespaces)
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        
        guard let doublePrice = formatter.number(from: price) else {
            return nil
        }
        
        let discountedPrice = Double.setDiscount(discount, to: doublePrice.doubleValue)
        
        return currency(from: Decimal(discountedPrice))
    }
    
    static func distanceInKilometers(from distance: Double?) -> String? {
        guard let distance = distance else {
            return nil
        }
        
        return String(format: "%.2f km", distance)
    }
    
    mutating func space() {
        self.append(" ")
    }
}

// MARK: - String Constants
struct StringConstants {
    static let paymentButtonFormat = "%@ %@ - %@!"
    
    static let attendants = NSLocalizedString("Attendants", comment: "")
    static let events = NSLocalizedString("Events", comment: "")
    static let eventDetails = NSLocalizedString("EventDetails", comment: "")
    static let purchaseDetails = NSLocalizedString("PurchaseDetails", comment: "")
    static let date = NSLocalizedString("Date", comment: "")
    static let about = NSLocalizedString("About", comment: "")
    static let location = NSLocalizedString("Location", comment: "")
    static let from = NSLocalizedString("From", comment: "")
    static let getIt = NSLocalizedString("GetIt", comment: "")
    static let success = NSLocalizedString("Success", comment: "")
    
    static let checkoutEvent = NSLocalizedString("CheckoutEvent", comment: "")
    static let successMessage = NSLocalizedString("SuccessMessage", comment: "")
}

struct ErrorConstants {
    static let attentionTitle = NSLocalizedString("Attention", comment: "")
    static let paymentProcessingError = NSLocalizedString("PaymentProcessingError", comment: "")
    static let genericFetchError = NSLocalizedString("GenericFetchError", comment: "")
    static let genericSerializationError = NSLocalizedString("GenericSerializationError", comment: "")
    static let provideNameErrorMessage = NSLocalizedString("ProvideNameErrorMessage", comment: "")
    static let provideEmailErrorMessage = NSLocalizedString("ProvideEmailErrorMessage", comment: "")
}
