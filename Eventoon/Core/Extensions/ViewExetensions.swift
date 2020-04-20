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
    
    func roundedCorners() {
        cornerOn(.all, radius: frame.height / 2)
    }
    
    func flatCorners() {
        cornerOn(.all, radius: 0)
    }
    
    func addBorder(borderWidth: CGFloat, borderColor: UIColor) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    func shakeAnimation() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: nil)
    }
    
    func pulseAnimation() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 0.95
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
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

