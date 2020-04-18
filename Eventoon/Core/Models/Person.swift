//
//  Person.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 18/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

struct Person: Decodable {
    let id: String
    let name: String
    let picture: String?
    let eventId: String?
}

extension Person: ParseDelegate {
    typealias ParseModel = Person
}
