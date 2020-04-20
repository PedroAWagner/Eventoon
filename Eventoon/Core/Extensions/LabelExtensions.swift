//
//  LabelExtensions.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 19/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

extension UILabel {
    @IBInspectable
    var localizableString: String {
        get {
            return NSLocalizedString(self.localizableString, comment: "")
        }
        set {
            self.text = NSLocalizedString(newValue, comment: "")
        }
    }
}


