//
//  DoubleExtensions.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 17/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    static func setDiscount(_ discount: Int, to price: Double) -> Double {
        let discountPrice = (price * Double(discount)) / 100
        return price - discountPrice
    }
}
