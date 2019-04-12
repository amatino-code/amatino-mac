//
//  LedgerIdleView.swift
//  Amatino
//
//  Created by Hugh Jeremy on 22/11/18.
//  Copyright © 2018 Amatino Pty Ltd. All rights reserved.
//

import Foundation
import Cocoa

class LedgerIdleView: NSView {
    
    let idleLabel: Label
    let idleText = NSLocalizedString("No account selected", comment:  "")

    override init(frame frameRect: NSRect) {
        idleLabel = Label(frame: NSMakeRect(0, 0, 100, 40))
        super.init(frame: frameRect)
        
        idleLabel.stringValue = idleText
        idleLabel.alignment = .center
        
        idleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(
            item: idleLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1,
            constant: 0
        )
        
        let verticalConstraint = NSLayoutConstraint(
            item: idleLabel,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1,
            constant: 0
        )
        
        addConstraint(horizontalConstraint)
        addConstraint(verticalConstraint)
        
        addSubview(idleLabel)
        
        return
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
