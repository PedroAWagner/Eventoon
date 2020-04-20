//
//  CheckoutService.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 19/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

final class CheckoutService {
    static func checkout(event: Event, user: User, completion: @escaping(Bool) -> Void) {
        let body = ["eventId": event.id, "name": user.name, "email": user.email]
        BaseAPIService.shared.post(url: APIEnvironment.shared.getUrl(for: .checkin), body: body, noConnection: {
            #warning("properly handle error")
        }, completion: { data, error in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
}
