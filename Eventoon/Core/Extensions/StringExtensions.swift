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
    static let attendants = "Attending"
    static let events = "Events"
    static let eventDetails = "Event Details"
    static let ticketDetails = "Ticket Details"
    static let date = "Date"
    
    static let checkoutEvent = "Hey! I found the event '{eventName}' on Eventoon. Check it out!"
}
