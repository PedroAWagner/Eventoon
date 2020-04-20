//
//  TextFieldExtension.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 19/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

extension UITextField {
    @IBInspectable
    var localizablePlaceholder: String {
        get {
            return NSLocalizedString(self.localizablePlaceholder, comment: "")
        }
        set {
            NSLocalizedString(newValue, comment: "")
        }
    }
}
