//
//  User.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 19/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

struct User: Codable {
    var name: String
    var email: String
    
    static var currentUser: User?
}
