//
//  ViewExetensions.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 17/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

extension UIView {
    func cornerOn(_ corner: Corners, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = corner.mask
    }
}

//MARK:- Corner Struct
struct Corners: OptionSet {
    let rawValue: Int
    
    static let top = Corners(rawValue: 1)
    static let bottom = Corners(rawValue: 2)
    static let left = Corners(rawValue: 3)
    static let right = Corners(rawValue: 4)
    static let all = Corners(rawValue: 5)
    
    var mask: CACornerMask {
        var mask: CACornerMask = []
        
        if contains(.top) {
            mask.update(with: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        }
        
        if contains(.bottom) {
            mask.update(with: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }
        
        if contains(.left) {
            mask.update(with: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        }
        
        if contains(.right) {
            mask.update(with: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        }
        
        if contains(.all) {
            mask.update(with: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }
        
        return mask
    }
}

