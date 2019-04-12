//
//  LedgerLoadingView.swift
//  Amatino
//
//  Created by Hugh Jeremy on 22/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerLoadingView: NSView {
    
    private let spinnerFrame = NSMakeRect(0, 0, 35, 35)
    private let spinner: NSProgressIndicator
    
    override init(frame frameRect: NSRect) {
        spinner = NSProgressIndicator(frame: spinnerFrame)
        spinner.isIndeterminate = true
        spinner.style = .spinning
        super.init(frame: frameRect)
        addSubview(spinner)
        
        let horizontalConstraint = NSLayoutConstraint(
            item: spinner,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        )
        
        let verticalConstraint = NSLayoutConstraint(
            item: spinner,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1,
            constant: 0
        )
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(horizontalConstraint)
        addConstraint(verticalConstraint)
        
        return
    }
    
    override func viewDidHide() {
        stopAnimation()
        super.viewDidHide()
        return
    }
    
    override func viewDidUnhide() {
        startAnimation()
        super.viewDidUnhide()
        return
    }
    
    public func startAnimation() { spinner.startAnimation(self) }
    public func stopAnimation() { spinner.stopAnimation(self) }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
