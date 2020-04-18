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
    
    func roundedBorders() {
        cornerOn(.all, radius: frame.height / 2)
    }
    
    func setGradientBackground(_ colors: UIColor ...) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.colors = colors.map { $0.cgColor }
        
        layer.insertSublayer(gradientLayer, at: 0)
        clipsToBounds = true
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

