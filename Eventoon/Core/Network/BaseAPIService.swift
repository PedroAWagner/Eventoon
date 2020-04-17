//
//  BaseAPIService.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation

typealias bodyJSON = [String: Any]

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class BaseAPIService {
    static let shared = BaseAPIService()
    
    func get(url: String, noConnection: @escaping () -> Void, completion: @escaping (Data?, String?) -> Void) {
        guard let url = URL(string: url) else {
            #warning("Properly handle this error message")
            completion(nil, "Error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(nil, error?.localizedDescription)
                return
            }
            completion(data, nil)
        }
        
        task.resume()
    }
    
    func post(url: String, body: bodyJSON, noConnection: @escaping () -> Void, completion: @escaping (Data?, String?) -> Void) {
        guard let url = URL(string: url) else {
            #warning("Properly handle this error message")
            completion(nil, "Error")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.post.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            #warning("Properly handle this error message")
            return
        }
        
        let task = URLSession.shared.uploadTask(with: request, from: jsonBody) { data, response, error in
            guard error == nil else {
                completion(nil, error?.localizedDescription)
                return
            }
            completion(data, nil)
        }
        
        task.resume()
    }
}
