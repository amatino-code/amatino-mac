//
//  NSView.swift
//  Amatino
//
//  Created by Hugh Jeremy on 9/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

extension NSView {
    
    var centre: CGPoint {
        get {
            return CGPoint(x: NSMidX(self.frame), y: NSMidY(self.frame))
        }
    }
    
    func shake() {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        
        shakeAnimation.duration = 0.07
        shakeAnimation.repeatCount = 3
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = CGPoint(
            x: NSMinX(frame) - 10,
            y: NSMinY(frame)
        )
        shakeAnimation.toValue = CGPoint(
            x: NSMinX(frame) + 10,
            y: NSMinY(frame)
        )

        layer?.add(shakeAnimation, forKey: "")
    }
    
}
