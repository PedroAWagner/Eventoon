//
//  EventsService.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

final class EventsService {
    static func getEvents(completion: @escaping([Event]?, Error?) -> Void) {
        BaseAPIService.shared.get(url: "http://5b840ba5db24a100142dcd8c.mockapi.io/api/events", noConnection: {
            #warning("Properly handle this error message")
            return
        }, completion: { data, error in
            guard error == nil else {
                #warning("Properly handle this error message")
                return
            }
            guard let data = data else {
                #warning("Properly handle this error message")
                return
            }
            completion(Event.parseArray(data: data), nil)
        })
    }
}
