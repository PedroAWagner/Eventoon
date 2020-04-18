//
//  Event.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

struct Event: Decodable {
    let id: String
    let title: String
    let description: String?
    let date: Int
    let price: Decimal?
    let longitude: Double
    let latitude: Double
    let image: String?
    let people: [Person]?
    let cupons: [Cupon]?

    enum CodingKeys: String, CodingKey {
        case id,
        title,
        description,
        date,
        price,
        longitude,
        latitude,
        image,
        people,
        cupons
    }
}

extension Event: ParseDelegate {
    typealias ParseModel = Event
}
