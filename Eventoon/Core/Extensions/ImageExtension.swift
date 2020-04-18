//
//  ImageExtension.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 17/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

extension UIImage {
    convenience init?(assetIdentifier: UIImageAssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }
}

enum UIImageAssetIdentifier: String {
    case dollarSign
    case imagePlaceholder
    case leftArrow
    case personGray
    case personWhite
    case placemarkerGray
    case placemarkerWhite
    case share
    case clockWhite
    case clockGray
}

