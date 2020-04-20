//
//  EventsService.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

final class EventsService {
    static func getEvents(completion: @escaping([Event]?, String?) -> Void) {
        BaseAPIService.shared.get(url: APIEnvironment.shared.getUrl(for: .events), noConnection: {
            #warning("Properly handle this error message")
            return
        }, completion: { data, error in
            guard error == nil else {
                completion(nil, ErrorConstants.genericFetchError)
                return
            }
            guard let data = data else {
                completion(nil, ErrorConstants.genericFetchError)
                return
            }
            completion(Event.parseArray(data: data), nil)
        })
    }
    
    static func getEvent(with id: String, completion: @escaping(Event?, String?) -> Void) {
        BaseAPIService.shared.get(url: APIEnvironment.shared.getUrl(for: .eventDetails, parameters: [.eventId: id]), noConnection: {
            #warning("Properly handle this error message")
            return
        }, completion: { data, error in
            guard error == nil else {
                completion(nil, ErrorConstants.genericFetchError)
                return
            }
            guard let data = data else {
                completion(nil, ErrorConstants.genericFetchError)
                return
            }
            completion(Event.parseObject(data: data), nil)
        })
    }
}
