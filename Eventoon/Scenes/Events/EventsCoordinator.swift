//
//  EventsCoordinator.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

protocol EventsCoordinatorActions {
    func showEventsDetail(eventId: String)
    func popViewController()
    func dismissViewController()
    func purchaseTicket(event: Event)
    func createUser()
}

final class EventsCoordinator: Coordinator {
    
    private let window: UIWindow?
    private let presenter: UINavigationController
    
    init(window: UIWindow?) {
        self.window = window
        let eventsViewController = EventsViewController()
        let presenter = UINavigationController(rootViewController: eventsViewController)
        self.presenter = presenter
        eventsViewController.coordinatorActions = self
    }
    
    func start() {
        setupPresenter()
        window?.rootViewController = presenter
        window?.makeKeyAndVisible()
    }
    
    private func setupPresenter() {
        presenter.navigationBar.barTintColor = .baseGray
        presenter.navigationBar.tintColor = .white
        presenter.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        presenter.interactivePopGestureRecognizer?.delegate = nil
    }
}

// MARK: - Extension: EventsCoordinatorActions
extension EventsCoordinator: EventsCoordinatorActions {
    func showEventsDetail(eventId: String) {
        let detailsViewModel = EventDetailsViewModel(eventId: eventId)
        let detailsViewController = EventDetailsViewController(viewModel: detailsViewModel)
        detailsViewController.coordinatorActions = self
        
        presenter.pushViewController(detailsViewController, animated: true)
    }
    
    func popViewController() {
        presenter.popViewController(animated: true)
    }
    
    func purchaseTicket(event: Event) {
        let checkoutCoordinator = CheckoutCoordinator(presenter: self.presenter, event: event)
        checkoutCoordinator.start()
    }
    
    func createUser() {
        let createUserViewModel = CreateUserViewModel(coordinatorActions: self)
        let createUserViewController = CreateUserViewController(viewModel: createUserViewModel)
        createUserViewController.isModalInPresentation = true
        presenter.present(createUserViewController, animated: true)
    }
    
    func dismissViewController() {
        presenter.dismiss(animated: true, completion: nil)
    }
}
