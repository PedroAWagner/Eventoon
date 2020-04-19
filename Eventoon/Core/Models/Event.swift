//
//  Event.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit
import CoreLocation

struct Event: Decodable {
    let id: String
    let title: String
    let description: String?
    let date: Int
    let price: Decimal?
    let longitude: Double
    let latitude: Double
    let image: String?
    var address: String?
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
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
        date = try values.decode(Int.self, forKey: .date)
        price = try values.decode(Decimal.self, forKey: .price)
        longitude = try values.decode(Double.self, forKey: .longitude)
        latitude = try values.decode(Double.self, forKey: .latitude)
        image = try values.decode(String.self, forKey: .image)
        people = try values.decode([Person].self, forKey: .people)
        cupons = try values.decode([Cupon].self, forKey: .cupons)
        address = ""
    }

}

extension Event: ParseDelegate {
    typealias ParseModel = Event
}
