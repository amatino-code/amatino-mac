//
//  TreeOutlineLoadingView.swift
//  Amatino
//
//  Created by Hugh Jeremy on 19/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class TreeOutlineLoadingView: NSView {
    
    private let progressIndicator: NSProgressIndicator
    private let indicatorFrame = NSMakeRect(0, 0, 35, 35)
    private let indicatorWidth = CGFloat(35)
    private let indicatorHeight = CGFloat(35)
    
    override init(frame frameRect: NSRect) {

        progressIndicator = NSProgressIndicator(frame: indicatorFrame)
    
        super.init(frame: frameRect)
        self.wantsLayer = true
        
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false

        let horizontalConstraint = NSLayoutConstraint(
            item: progressIndicator,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        )
        
        let verticalConstraint = NSLayoutConstraint(
            item: progressIndicator,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1,
            constant: 0
        )
        
        self.addConstraint(horizontalConstraint)
        self.addConstraint(verticalConstraint)

        progressIndicator.isIndeterminate = true
        progressIndicator.style = .spinning
        addSubview(progressIndicator)
        return
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startAnimation() {
        self.progressIndicator.startAnimation(self)
        return
    }
    
    public func stopAnimation() {
        self.progressIndicator.stopAnimation(self)
        return
    }

}
