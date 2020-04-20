//
//  CreateUserViewModel.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 19/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import Foundation
import RxSwift

typealias UserCreationError = String

final class CreateUserViewModel {
    
    let coordinatorActions: EventsCoordinatorActions?
    let userCreationStream = PublishSubject<UserCreationError>()
    
    // MARK: - Init
    init(coordinatorActions: EventsCoordinatorActions?) {
        self.coordinatorActions = coordinatorActions
    }
    
    // MARK: - Actions
    func createUser(name: String?, email: String?) {
        guard let name = name,
            let email = email else {
                userCreationStream.onNext(UserCreationError("Some error message"))
                return
        }
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            userCreationStream.onNext(UserCreationError(ErrorConstants.provideNameErrorMessage))
            return
        }
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            userCreationStream.onNext(UserCreationError(ErrorConstants.provideEmailErrorMessage))
            return
        }
        
        let user = User(name: name, email: email)
        User.currentUser = user
        do {
            let userData = try JSONEncoder().encode(user)
            UserDefaults.standard.set(userData, forKey: "User")
            userCreationSuccess()
        } catch let error {
            userCreationStream.onNext(UserCreationError(error.localizedDescription))
        }
    }
    
    private func userCreationSuccess() {
        coordinatorActions?.dismissViewController()
    }
}
