//
//  DateExtension.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 17/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

extension Date {
    static func stringFromAPIDate(intDate: Int) -> String? {
        
        let date = Date(timeIntervalSince1970: Double(intDate))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"

        return formatter.string(from: date)
    }
}
