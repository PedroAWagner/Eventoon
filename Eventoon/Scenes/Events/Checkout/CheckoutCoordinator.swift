//
//  CheckoutCoordinator.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 18/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

protocol CheckoutCoordinatorActions {
    func popViewController()
    func goBackToEventList()
}

final class CheckoutCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private let event: Event
    
    init(presenter: UINavigationController, event: Event) {
        self.presenter = presenter
        self.event = event
    }
    
    func start() {
        let viewModel = PurchaseDetailsViewModel(event: event)
        let viewController = PurchaseDetailsViewController(viewModel: viewModel)
        viewController.coordinatorActions = self
        presenter.pushViewController(viewController, animated: true)
    }
}

// MARK: - Extension: CheckoutCoordinatorActions
extension CheckoutCoordinator: CheckoutCoordinatorActions {
    func popViewController() {
        presenter.popViewController(animated: true)
    }
    
    func goBackToEventList() {
        presenter.popToRootViewController(animated: true)
    }
}
