//
//  AlertHelper.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 19/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

class AlertHelper: NSObject {
    static func showAlertSimpleAction(title: String, message: String) {
        if var viewController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = viewController.presentedViewController {
                viewController = presentedViewController
            }
            let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            alert.preferredAction = okAction
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
