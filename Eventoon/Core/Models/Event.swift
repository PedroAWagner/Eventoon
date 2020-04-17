//
//  Event.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

struct Event: Decodable {
    let id: String
    let title: String
    let price: Decimal?

    enum CodingKeys: String, CodingKey {
        case id,
            title,
            price
    }
}

extension Event: ParseDelegate {
    typealias ParseModel = Event
}
