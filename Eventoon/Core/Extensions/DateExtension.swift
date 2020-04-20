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
        var stringUnixDate = String(intDate)
        let digits = stringUnixDate.compactMap({ $0.wholeNumberValue })
        if digits.count > 10 {
            stringUnixDate.insert(".", at: stringUnixDate.index(stringUnixDate.startIndex, offsetBy: 10))
        }
        
        let date = Date(timeIntervalSince1970: Double(stringUnixDate) ?? 0)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy - HH:mm"

        return formatter.string(from: date)
    }
}
