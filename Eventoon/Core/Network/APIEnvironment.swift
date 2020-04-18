//
//  APIEnvironment.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 17/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

struct APIEnvironment {
    static let shared = APIEnvironment()
    
    let baseURL = "http://5b840ba5db24a100142dcd8c.mockapi.io/api/"
    
    func getUrl(for endpoint: APIEnvironmentEndpoints, parameters: [EndpointParameters: String]? = nil) -> String {
        let url = baseURL + endpoint.rawValue
        
        guard let parameters = parameters else {
            return url
        }
        return replaceParameters(url: url, parameters: parameters)
    }
    
    private func replaceParameters(url: String, parameters: [EndpointParameters: String]) -> String {
        var parametizedURL = url
        for parameter in parameters {
            parametizedURL = parametizedURL.replacingOccurrences(of: parameter.key.rawValue, with: parameter.value)
        }
        return parametizedURL
    }
}

enum APIEnvironmentEndpoints: String {
    case events = "events"
    case eventDetails = "events/{eventId}"
    case checkin = "checkin"
}

enum EndpointParameters: String {
    case eventId = "{eventId}"
}
