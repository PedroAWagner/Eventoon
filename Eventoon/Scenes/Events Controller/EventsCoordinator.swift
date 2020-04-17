//
//  EventsCoordinator.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

final class EventsCoordinator: Coordinator {
    
    private let window: UIWindow?
    private let presenter: UINavigationController
    
    init(window: UIWindow?) {
        self.window = window
        let presenter = UINavigationController(rootViewController: EventsViewController())
        self.presenter = presenter
    }
    
    func start() {
        window?.rootViewController = presenter
        window?.makeKeyAndVisible()
    }
}
