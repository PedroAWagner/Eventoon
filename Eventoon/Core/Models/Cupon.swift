//
//  Cupon.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 18/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

struct Cupon: Decodable {
    let id: String
    let eventId: String
    let discount: Int
}

extension Cupon: ParseDelegate {
    typealias ParseModel = Cupon
}
